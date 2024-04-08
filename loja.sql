-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/04/2024 às 00:51
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `loja`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(100) DEFAULT NULL,
  `email_cliente` varchar(100) DEFAULT NULL,
  `telefone` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nome_cliente`, `email_cliente`, `telefone`) VALUES
(1, 'ruan', 'ruan@gmail.com', '12345'),
(2, 'pablo', 'pablo@gmail.com', '123654'),
(3, 'silva', 'silva@gmail.com', '1234'),
(4, 'diniz', 'diniz@gmail.com', '1245'),
(5, 'davi', 'davi@gmail.com', '12345'),
(6, 'bezerra', 'bezerra@gmail.com', '11111'),
(7, 'sousa', 'sousa@gmail.com', '12358'),
(8, 'maria', 'maria@gmail.com', '1236564'),
(9, 'catarina', 'catarina@gmail.com', '222222'),
(10, 'joao', 'joao@gmail.com', '5555');

-- --------------------------------------------------------

--
-- Estrutura para tabela `comissao`
--

CREATE TABLE `comissao` (
  `id` int(11) NOT NULL,
  `id_venda` int(11) DEFAULT NULL,
  `id_funcionario` int(11) DEFAULT NULL,
  `valor` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id_func` int(11) NOT NULL,
  `nome_func` varchar(100) DEFAULT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `data_contratacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id_func`, `nome_func`, `cargo`, `salario`, `data_contratacao`) VALUES
(1, 'Chico Marcio', 'Analista', 5000.00, '2024-04-01'),
(2, 'Maria Santos', 'Gerente', 8000.00, '2024-03-15'),
(3, 'Pedro Oliveira', 'Desenvolvedor', 4500.00, '2024-02-20'),
(4, 'Ana Pereira', 'Assistente', 3500.00, '2024-04-10'),
(5, 'Carlos Rodrigues', 'Analista', 5500.00, '2024-01-05'),
(6, 'Laura Costa', 'Coordenador', 7000.00, '2024-03-01'),
(7, 'Rafaela Almeida', 'Analista', 5200.00, '2024-02-10'),
(8, 'Fernando Souza', 'Desenvolvedor', 4800.00, '2024-04-05'),
(9, 'Mariana Lima', 'Assistente', 3200.00, '2024-03-20'),
(10, 'Gustavo Santos', 'Analista', 5800.00, '2024-01-15');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id_prod` int(11) NOT NULL,
  `nome_prod` varchar(100) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id_prod`, `nome_prod`, `descricao`, `preco`, `quantidade`) VALUES
(1, 'Camiseta Branca', 'Camiseta básica de algodão', 29.99, 100),
(2, 'Calça Jeans', 'Calça jeans slim fit', 59.90, 50),
(3, 'Tênis Esportivo', 'Tênis para corrida', 89.50, 30),
(4, 'Bolsa de Couro', 'Bolsa de ombro em couro sintético', 45.00, 20),
(5, 'Relógio Analógico', 'Relógio de pulso com mostrador analógico', 79.99, 15),
(6, 'Óculos de Sol', 'Óculos de sol estilo aviador', 34.95, 40),
(7, 'Perfume Floral', 'Perfume feminino com notas florais', 69.00, 25),
(8, 'Brinco Prateado', 'Brinco pequeno em prata', 12.50, 80),
(9, 'Cinto de Couro', 'Cinto de couro legítimo', 39.75, 35),
(10, 'Meia Algodão', 'Par de meias confortáveis', 5.99, 198);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendas`
--

CREATE TABLE `vendas` (
  `id_venda` int(11) NOT NULL,
  `id_produtos` int(11) DEFAULT NULL,
  `id_funcionario` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `data_venda` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendas`
--

INSERT INTO `vendas` (`id_venda`, `id_produtos`, `id_funcionario`, `id_cliente`, `quantidade`, `total`, `data_venda`) VALUES
(1, 10, 3, 1, 1, 1.00, '2024-04-08'),
(2, 10, 10, 1, 1, 1.00, '2024-04-08');

--
-- Acionadores `vendas`
--
DELIMITER $$
CREATE TRIGGER `atualizar_estoque_venda` AFTER INSERT ON `vendas` FOR EACH ROW BEGIN 
    DECLARE estoque_atual INT;
    DECLARE quantidade_vendida INT;
    
    SELECT quantidade INTO quantidade_vendida FROM vendas WHERE id_venda = NEW.id_venda;
    
    UPDATE produtos SET quantidade = quantidade - quantidade_vendida WHERE id_prod = NEW.id_produtos;
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `comissao`
--
ALTER TABLE `comissao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venda` (`id_venda`),
  ADD KEY `id_funcionario` (`id_funcionario`);

--
-- Índices de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id_func`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id_prod`);

--
-- Índices de tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`id_venda`),
  ADD KEY `id_produtos` (`id_produtos`),
  ADD KEY `id_funcionario` (`id_funcionario`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `comissao`
--
ALTER TABLE `comissao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id_func` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id_prod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `id_venda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `comissao`
--
ALTER TABLE `comissao`
  ADD CONSTRAINT `comissao_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `vendas` (`id_venda`),
  ADD CONSTRAINT `comissao_ibfk_2` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_func`);

--
-- Restrições para tabelas `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`id_produtos`) REFERENCES `produtos` (`id_prod`),
  ADD CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_func`),
  ADD CONSTRAINT `vendas_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
