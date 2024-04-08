**# Gatilhos (Triggers) para Atualização de Estoque e Comissão**

Este repositório contém **dois gatilhos (triggers)** que podem ser utilizados em um banco de dados relacionado a uma loja ou sistema de vendas. Vamos explicar cada um deles:

## 1. Gatilho para Atualização de Estoque de Vendas

### Descrição
O gatilho `atualizar_estoque_venda` é acionado automaticamente após a inserção de uma nova venda na tabela `vendas`. Ele tem como objetivo atualizar o estoque de produtos, subtraindo a quantidade vendida do estoque existente.

### Funcionamento
1. Quando uma nova venda é registrada na tabela `vendas`, o gatilho é acionado.
2. Ele recupera a quantidade vendida da venda recém-inserida.
3. Em seguida, atualiza o estoque do produto correspondente na tabela `produtos`.

```sql
DELIMITER //

CREATE TRIGGER atualizar_estoque_venda AFTER INSERT ON vendas
FOR EACH ROW 
BEGIN 
    DECLARE estoque_atual INT;
    DECLARE quantidade_vendida INT;
    
    SELECT quantidade INTO quantidade_vendida FROM vendas WHERE id_venda = NEW.id_venda;
    
    UPDATE produtos SET quantidade = quantidade - quantidade_vendida WHERE id_prod = NEW.id_produtos;
END;

//

DELIMITER ;
```

## 2. Gatilho para Inserção de Comissão

### Descrição
O gatilho `inserir_comissao` é acionado após a inserção de uma nova venda na tabela `vendas`. Ele calcula a comissão a ser paga ao funcionário responsável pela venda, com base no valor da venda.

### Funcionamento
1. Quando uma nova venda é registrada na tabela `vendas`, o gatilho é acionado.
2. Ele recupera o valor da venda recém-inserida.
3. Se o valor da venda for igual ou superior a **100 unidades monetárias**, o gatilho calcula a comissão como **1% do valor da venda**.
4. A comissão é então inserida na tabela `comissao`, associando-a à venda e ao funcionário responsável.

```sql
DELIMITER //

CREATE TRIGGER inserir_comissao AFTER INSERT ON vendas
FOR EACH ROW 
BEGIN 
   DECLARE valor DECIMAL(10,2);
   DECLARE valor_comissao DECIMAL(10,2);
   SELECT valor INTO valor FROM vendas WHERE id = NEW.id_venda;
   IF valor >= 100 THEN 
       SET valor_comissao = valor * 0.01;
       INSERT INTO comissao (id_venda, id_func, valor) VALUES
         (NEW.id_venda, NEW.id_func, valor_comissao);
   END IF;
END;

//

DELIMITER ;
```

## 3. Gatilho para Deleção de Produto quando o Estoque Chega a Zero
### Descrição
O gatilho deletar_produto é acionado automaticamente após uma atualização na quantidade de um produto na tabela produtos. Ele verifica se a quantidade do produto foi atualizada para zero e, nesse caso, deleta o registro do produto da tabela.

### Funcionamento
1. Quando a quantidade de um produto na tabela produtos é atualizada, o gatilho é acionado.
2. Ele verifica se a nova quantidade é igual a zero.
3. Se a quantidade for zero, o gatilho deleta o registro do produto da tabela.
```sql
DELIMITER //

CREATE TRIGGER deletar_produto AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.quantidade = 0 THEN
        DELETE FROM produtos WHERE id_prod = NEW.id_prod;
    END IF;
END;

//

DELIMITER ;
```
Este gatilho garante que os produtos com estoque zerado sejam automaticamente removidos da tabela, mantendo-a atualizada e livre de produtos indisponíveis. Certifique-se de ajustar conforme necessário e execute-o no seu banco de dados.
