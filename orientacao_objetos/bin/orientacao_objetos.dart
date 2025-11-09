import 'package:orientacao_objetos/conta.dart';

void main() {
  ContaCorrente contaChris = ContaCorrente("Chris", 4000);
  ContaPoupanca contaDenize = ContaPoupanca("Denize", 4000);
  ContaEmpresa contaMatheus = ContaEmpresa("Matheus", 2000);
  ContaInvestimento contaRoberta = ContaInvestimento("Roberta", 2000);

  contaChris.receber(100);
  contaChris.imprimeSaldo();
  contaChris.enviar(4400);

  contaDenize.enviar(100);
  contaDenize.imprimeSaldo();
  contaDenize.calculaRendimento();
  contaDenize.imprimeSaldo();

  contaMatheus.enviar(1000);

  contaRoberta.receber(1000);
}