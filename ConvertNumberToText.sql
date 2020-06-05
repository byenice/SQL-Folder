create function udf_sayiyi_yaziya_cevirme(
 @sayi bigint,
 @buyukharf bit
)
returns nvarchar(max)
-- developed by Eralper (http://www.kodyaz.com)
begin

declare @yaziilesayi nvarchar(max)
set @yaziilesayi = N''

declare @sayivarchar varchar(100)
set @sayivarchar = cast(@sayi as varchar(100))

declare @toplambasamak smallint
set @toplambasamak = len(@sayivarchar)

declare @basamak smallint
declare @rakam tinyint

declare @i smallint
set @i = 0

while @i < @toplambasamak
begin
 set @basamak = @toplambasamak - @i
 set @i = @i + 1
-- s�ra ile soldan ba�layarak rakamlar� oku
 set @rakam = substring(@sayivarchar, @i, 1)

 select
  @yaziilesayi = @yaziilesayi +
-- rakam�n basamak de�eri g�z�n�ne al�narak metin olu�turuluyor
  case @rakam
  when 0 then N''
  when 1 then
   case @basamak % 3 when 0 then N'y�z' when 2 then N'on' when 1 then
    case when @toplambasamak = 4 and @i = 1 then N'' else
     case when @i = @toplambasamak then N'bir' else
      case when substring(@sayivarchar, @i-2, 2) = '00'
       then N'' else N'bir'
      end
     end
    end
   end
  when 2 then
   case @basamak % 3
    when 0 then N'iki y�z' when 2 then N'yirmi' when 1 then N'iki' end
  when 3 then
   case @basamak % 3
    when 0 then N'�� y�z' when 2 then N'otuz' when 1 then N'��' end
  when 4 then
   case @basamak % 3
    when 0 then N'd�rt y�z' when 2 then N'k�rk' when 1 then N'd�rt' end
  when 5 then
   case @basamak % 3
    when 0 then N'be� y�z' when 2 then N'elli' when 1 then N'be�' end
  when 6 then
   case @basamak % 3
    when 0 then N'alt� y�z' when 2 then N'altm��' when 1 then N'alt�' end
  when 7 then
   case @basamak % 3
    when 0 then N'yedi y�z' when 2 then N'yetmi�' when 1 then N'yedi' end
  when 8 then
   case @basamak % 3
    when 0 then N'sekiz y�z' when 2 then N'seksen' when 1 then N'sekiz' end
  when 9 then
   case @basamak % 3
    when 0 then N'dokuz y�z' when 2 then N'doksan' when 1 then N'dokuz' end
  end + space(1) +
  case @basamak
   when 4 then
    case when substring(reverse(@sayivarchar), @basamak, 3) = '000' then N'' else N'bin' end
   when 7 then
    case when substring(reverse(@sayivarchar), @basamak, 3) = '000' then N'' else N'milyon' end
   when 10 then
    case when substring(reverse(@sayivarchar), @basamak, 3) = '000' then N'' else N'milyar' end
   when 13 then
    case when substring(reverse(@sayivarchar), @basamak, 3) = '000' then N'' else N'trilyon' end
   when 16 then
    case when substring(reverse(@sayivarchar), @basamak, 3) = '000' then N'' else N'katrilyon' end
   else N''
  end + space(1)
end

-- �evrim s�ras�nda olu�abilecek fazla SPACE karakterleri temizleniyor
set @yaziilesayi = ltrim(rtrim(@yaziilesayi))

WHILE REPLACE(@yaziilesayi, space(2), space(1)) <> @yaziilesayi
BEGIN
 SELECT @yaziilesayi = REPLACE(@yaziilesayi, space(2), space(1))
END

-- Metin b�y�k harflerle isteniyorsa UPPER fonksiyonu kullan�l�yor
if @buyukharf = 1
 set @yaziilesayi = UPPER(@yaziilesayi collate turkish_ci_as)

-- say�n�n yaz� ile ifadesini i�eren de�i�ken d�nd�r�l�yor
return @yaziilesayi

end