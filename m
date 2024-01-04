Return-Path: <linux-ext4+bounces-690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C7A824362
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A066F287370
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD347224C0;
	Thu,  4 Jan 2024 14:13:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CD225A1
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 6505A25A81
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 09:13:54 -0500 (EST)
Message-ID: <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
Subject: Re: e2scrub finds corruption immediately after mounting
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-ext4@vger.kernel.org
Date: Thu, 04 Jan 2024 09:13:53 -0500
In-Reply-To: <20240104045540.GD36164@frogsfrogsfrogs>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
	 <20240104045540.GD36164@frogsfrogsfrogs>
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=mQINBFJXCMcBEADE0HqaCnLZu2Iesx727mXjyJIX6KFGmGiE5eXBcLApM5gtrQM5x+82h1iKze30VR9UKNzHz50m6dvUxXz2IhN+uprfSNtooWU5Lp6YO8wZoicCWU+oJbQC/BvYIiHK6WpuSFhGY7GVtbP64nn9T+V/56FQcMV3htP1Ttb3fK4+b4GKU5VlDgk8VkURi/aZfKP34rFZyxAXKhG+wSgQCyRZihy6WWIKYhhgXnpMlPX1GqXaZZcIiZwk+/YXo33rXPscC0pnOHtpZAOzMo8YeDmmlBjVjrno2aLqxOOIKYrtGk7yyZArxqeLdOdFuQnp/zwWnWlVSiuqStTpY18hNlMx2R43aj/APy8lLNsvgDUIeErkjpePXB86qoTds7+smw9u0BRGwX2aaaHvd2iIInFwjm/VazWbv7cQPNpWeR0+pDuTLIop6qkvInPc7FkQJEsiFJGrFP4kslFCgkpUovxsCdYs5Re4kJmGZ7QNgr2TVvUjW0NRQiKDfqQxP5rMPeSSatpgk1m7qXCOGefp71fkh9u/xViDzeCIyPpS0cySAGrVkhgKcNi1JVs0bW4zp7rA3klKqvnfoQKsqNDmp9kWgMB/3qtTU2pkUnO5lfCeOlZTWZw801420Kx/fWxj0JuLMfxH07/F9JA1u97yRIWlXraPbWMXfeeKlZY+3YG+gQARAQABtClCcmlhbiBKLiBNdXJyZWxsIDxicmlhbkBicmlhbi5tdXJyZWxsLmNhPokCTgQTAQgAOBYhBAMAmivcnutVhqR+1xzy2ObpTg0YBQJfqq9JAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEBzy2ObpTg0YFUAP/iM3LG3+WalZS+QV99Rf6XSNGrvc/1IpfAK7YHTCES3bUt1KrhM2sYJBHnx75FpWY33/Wp/aKApQvJ1AV/uDcOz0lfdH4nN9TB3zerG7H9bPt+P5myc7vo5hp
	6ypq6ytifbpKDIJoxUVqGhXIm4r7aF+FBOh6iVCW0Urd/ELsdxv9xzTyvalmyOPYy9J5J3GWda9+MKdI53wyJSlcqFnG2VhOyLC+3+gYwpt6CAXh3QxFp61BzOn6RBUrXkD4Olock+4yMgCobnCTjfyawd8vmkvNsmNFBg+w+sevgAuV9nzNni+Jug1KYVzqMrrwSrDiVJYQSXsky0U8TcUfnRO89ISFylediS6L2t3+lGQvf0JZ5hBD2sc01jx2hj5EQTKftWKQEEAGm1l8jeZDWOims9JJzgJYS6Suu7NIzizmO1OlFA+Bozf8jZpAg3qknKz1I4bS9lIov6wU49lP7fkRsvhf6G2AM2xZ1w4ydbcRrbOnzJVqnYnJrxypG3ODNF5Op6PCUYgSI0NiEIEeNMZEmBcy3YkR4NueGj1892QAqtOb+i4ys1LUVPm6JBathZ47Br1KZ0xYzNW7n6vrVHj//Uw2nutFRPA4gpksBomxFJ47yAWPS02qoRdyXa4Ejke53b7DEKA+H3hHTQACeM0L9xhhKqgxVn7lRapLpiLekkJtCNCcmlhbiBKLiBNdXJyZWxsIDxicmlhbkBtdXJyZWxsLmNhPokCOAQTAQIAIgUCUlcXXgIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHPLY5ulODRi7fQ//TKq+ilyhgYN7m1BL+pxdslB1pKmurIBZd4wLppzQINQpG5sLFlKdARvD9l0GtJETKP31HhDPvvFQK8cZYfSsm+gt9lGVW/wtEo19fINeU3FYh5aLhR5n7nFArBMSMbWn9MsQMlUoMLvnGvs4TjYe9aDKsYUzIpoqgmVySr1+g/aSi4ZjyKmdiw9bcQdIUm0TyuaoHDDNvYIRd06n0wD2PdHkX1VPojCaqSBMb0G4vxsNGW3MMRe6tszF+O3o0xCTI5mAVCrXh7buwR6GsQam6j048fAGxJAXV+tngCwLgq0P8a39lt
	AW/XSlGdfePihwE6rjGQLh2lhXIKMqiLlK/OZmNxWd2xnfzw+DlfUTUyE70+3/WZ6EdqM6PSxFQ0MA2zgw20KMqSu58EZpu7m6qsCGzINNaXcuaqZclEgboOnxtBPhbo1J1UVpFN91RzwkLAGpOvlFtjUs/xWCQRyeXCRRA6TsqF5U6nh/iHVRnZDiMCIcSZjx8NwQIygvGsmK+cYvkXz17QC3GiAGblaLmh6YFbzlw/W4oGZ7vURl+bXZ7j1FtFfmIJzSff5TbZT2bLqXKxmtZRbI1SnJ37kwDn9Tht5MuXwLEj3KcqQZaQ4dS+dGwYljQX4PTYsoqbTsa+Gr8kwcG8tdD9iTt0VzA7l8vOUvwsN4eVsYDoS3Y8W0KEJyaWFuIEouIE11cnJlbGwgPGJyaWFuQGludGVybGlueC5iYy5jYT6JAlIEEwEIADwCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEAwCaK9ye61WGpH7XHPLY5ulODRgFAl+qz2ECGQEACgkQHPLY5ulODRjccRAAje/Upu2YhJYEal1UulC9r+iYMxc+AN8W51E76xtOZtmA/ijp8DgVJUQPoTZx9jj82V61cm6P9kvply94/VKsO+A8jFrExD2btcw/d8ynFvgrrFR+HzYD2qg3U0CvLCt7cunItxQd/ARWuUm64v/QEmxDa4pP9GXHUWMX8hhhYr7ixC4wiYrNHBf7dupaKjwdJRd2iaPuMG16+ulJFi+TfFIjO6QY3zHjSFk27Knj6Q6zeJ2l8iJCbf+nVyvaeKvYhXg+bAKdOcsgbkqLGuO0J1/7q2oPIiXa7peMF7ngQQ/kKVU+e0rk/x0U1tUGtemXPD0fN3ZbUVcK9qO2PDYtQsCOvM0+luHBGuSrb8bx4Ud3fEYeKjDi8YLAalHl1nE5tFRKNJRCnqOwV46S/i9fzKlGsXy6zesPbSIBujgyb3the3ZoAfTxaQTDzcYAjOmSddU
	G5hoPHQdKXmXTaM5wGUacQi9LIxHi5UDo38PDFCzfHDwjM/gAoCf8WecjY1wA+6ammbAhpJcmd1k0rjcY5oDnSVlBSFgUfvi79KUW/MYNq0BSeedX3DMdqj4aRZYnr+atFzZV/hKievamxDZQIqrcsy5gAd52YFwmhpGDpcZZ33/E5pAxLErSOAgu8VKjwwvd75t3pDmZ6+HSj6895sPAa/bx50b94up8LYQLXYm5AQ0EUlcS5AEIAKXoj30MbWUf8+i5Xq3o0+eAC+GlCpu7xnamXHHCRvQY4xbN5p9ESxDJnceb5SFddyH+H2MNcGSHfCYknBOxKAV+PPFd5rtFfa5eDY025mReMRr7teK4uzU8SND3yujBO1mjTSuxccBRuv/v6Q+7roc0dEqq4Ko8Sj4DNFF+TSKrVDQJJy6ZrXQiznSn+aglMLYqcQ9BwogbCSR2S3I0S9MvjXQjK5WX+FvJP7dX2auMry2nVA1efPoEiKdp5B+NIy2jp/OijkXUL9Fh7WkFZNpRi8o9hFaaJ42P3lkJpxVfeouva+F35ZNm2D85fXfechBiw+8vZ6Iw0bIKjNOp0CMAEQEAAYkDPgQYAQIACQUCUlcS5AIbAgEpCRAc8tjm6U4NGMBdIAQZAQIABgUCUlcS5AAKCRDawdA0FsvIoEY3B/91ria7wjaBFm/ZLV/HZ6QVO4MlU+1BrRXALcYypkBoxxJahpIHYf4NHlMEiX41kSzLp+HvfCtwGwVIQS7LblQKx021kRbpzlnXOG+Sw2KpcvhK8BYBvwX7yRrNe2GpR9Sm2mK4ix+Kf8aMJ33zocxSoWyxrNa9sQiksetqL2jioXVEdpxAcsFj046AJmIJkYj61HzOd/NQCfagJESrCrCpNXOrdH5U/R4GW5QgZSR18x8J8u6e9yCmpuQ6F7qjF+Fiub5cDQ1MXVk6N2aoJW8Y3//oJqIdAJUf+iJ2tHVV+SfFAtmw3XaOQIe2dTsVEn6D
	tpe4ttU3863tqWjvfRcdd5UQAJ6G/2JSereq9AUR+hp2Ay0mtp+ErWIq/ynXkrUWwTMD9UQVikpTbfrdh9jPBTCm8/JN0VoTj4XYwcASvvWxjsdSx4Jd5VOGklb1RlowpRgmpYt68CRKfBIHyrP2w+NNN9mq10RMj8WLHrCCtuixDrHnQmf3IAPom/Km3TmCPBia4kkx6mfdsN7G96SQHjPsGwwj2QNYQufKEjXPnhEp8Z9JIy40gFIXn9jEGaavW1C/2gmeC6Joe+NbkA3FscMbYzAK0EvjCe06M+ReJHIj702q6FqqhrTfPW6JFcHCxR9y16hpW8WroSfahxRV4MikJOwi0NdXY7Mi6HHuYZPQEXdmSb1GjZWgn83TlnrYKQVd4/7Fgt1kbRs97wr1okD0a/QvimKVwLOKlxmTqS1q+5qgcud6aWUu3dfIBsW0CblRv50DHySFhMp7JsWrZ776OSHmgSqh/RBTfc0vwu8q37hiOMjNY02LetUHVzFkXDlLHQ1OpuZnkE0RdJydB+ET1mhOLYpkoqV86MCMjCFxi/dwOuDjOZHRFAf7DhJH6GlXEjr5ZAAZRoNp2XZTPJQwF7oFmPXxe7/4nT32Pl0qu+nbt5m3HEwy9i3p2BFsNv/3HWmvjcNSfpQ7Nu3Wxcrpyw6Xqai7tJjjFaOLvo5Pz4jU87Y5Bout3z1R2I54GD4FuQENBFJXFA4BCACqOEdaaQwxVnbUnl3CfdPELFN35FQBjck3KQ9KE44Pfd4ZvG+xUlu0BUot4j3T8mMPRfEvM4lBYcL8BNIE+k9qCARPxv1aPPPiBvIk2ollxclPBwy4Cc3bg1kLgwcADxO1UU5kQS96zfhF/f4swY1gKD7WiYtfU3KdaJvd7s7lq9dE5HQFMctsBwLlFrlAxi2NugxMwc24AWXLB0HJM9ja16JUtkYfwS14ZH+qYiHcqIKtPezVLq8lq1BwC3EMsrxz13sfQ9zePJz40CaO+
	+/KZ3yZJE1C1IG1vphQ9S18Egc/cOtr+3IleKSpRXtvyu3E7NaH8e+mdJZN+IfJkznjABEBAAGJAh8EGAECAAkFAlJXFA4CGwwACgkQHPLY5ulODRh9nRAAwlNsQjXocO4tzO0SczBHFpRSEvGRpM4CEhBO60h9G//UIdRfAslxpYXlOOZ8yrNYCRk9wD2kwiJVq/BvZpVt0TBqbpI9xcEHxL9JsDSCNz9oaik+HyOsNKkVTwvC8fs49xuJ47mwNXRHk307e3V7KTQGTb3jnhr28xTA2f7GS+htAaN9Ptf74sVxoHEAseNDAFGw51/TLhPmfnjXUFSr++KmcAzD96UOgC9pobCislZO3VBVimKOGJonlwUx4Ix8Eos5IWTg0yJXSI2ho2U/bOtaAkJjL92RWcO6BapF/dGHUH6yW7iu6O2ftx4nLTCet9z6fm0CNEX8T5ksNtPrxq/xUKViv7245yPaZtdASq0BkvEHKFROdnhuAX9qPvFTtrNXuX2dUIJSewS/IVdy4g3thpZ+tTpepoObpmGtssXXBvrPIg1HcQXmX0k9G0c+WkB9FvwKARbcOjaJdQv7OOwudd+Y8kVeSOnEHN0ECyEh2vAM4oEHp1i5tf/jvBviN9sP8vCE7JHBkMwEVZARNC0bNeOsFjTgUDpO725j7ya/MR3+qECizlQrL+r3Yf1m1LbKh2JTZuk4rNi2g37M0jiLm+QBnnI8UmfMTPsfmabRWfH98+EEbEqvvt74RMkphf4MKM39dtCp5KymE3yYEDVRVzggMKG6YgPxwdAuRXY=
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-CgMbNShrDZ/cRDUuSB4B"
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-CgMbNShrDZ/cRDUuSB4B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-03 at 20:55 -0800, Darrick J. Wong wrote:
> Curious.=C2=A0 Normally e2scrub will run e2fsck twice: Once in journal-
> only
> preen mode to replay the journal, then again with -fy to perform the
> full filesystem (snapshot) check.

It is doing that.  I suspect the first e2fsck is silent.

> I wonder if you would paste the output of
> "bash -x e2scrub /dev/rootvol_tmp/almalinux8_opt" here?=C2=A0 I'd be
> curious
> to see what the command flow is.

Sure.

+ PATH=3D/sbin:/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/=
.dotnet/tools
+ ((  0 !=3D 0  ))
+ snap_size_mb=3D256
+ fstrim=3D0
+ reap=3D0
+ e2fsck_opts=3D
+ conffile=3D/etc/e2scrub.conf
+ test -f /etc/e2scrub.conf
+ . /etc/e2scrub.conf
++ periodic_e2scrub=3D1
++ sender=3De2scrub@pvr.interlinx.bc.ca
+ getopts nrtV opt
+ shift 0
+ arg=3D/dev/rootvol_tmp/almalinux8_opt
+ '[' -z /dev/rootvol_tmp/almalinux8_opt ']'
+ type lsblk
+ type lvcreate
+ exec
+ '[' -b /dev/rootvol_tmp/almalinux8_opt ']'
++ dev_from_arg /dev/rootvol_tmp/almalinux8_opt
++ local dev=3D/dev/rootvol_tmp/almalinux8_opt
+++ lsblk -o FSTYPE -n /dev/rootvol_tmp/almalinux8_opt
++ local fstype=3Dext2
++ case "${fstype}" in
++ echo /dev/rootvol_tmp/almalinux8_opt
++ return 0
+ dev=3D/dev/rootvol_tmp/almalinux8_opt
++ mnt_from_dev /dev/rootvol_tmp/almalinux8_opt
++ local dev=3D/dev/rootvol_tmp/almalinux8_opt
++ '[' -n /dev/rootvol_tmp/almalinux8_opt ']'
++ lsblk -o MOUNTPOINT -n /dev/rootvol_tmp/almalinux8_opt
+ mnt=3D/opt
+ '[' '!' -e /dev/rootvol_tmp/almalinux8_opt ']'
++ lvs --nameprefixes -o name,vgname,lv_role --noheadings /dev/rootvol_tmp/=
almalinux8_opt
+ lvm_vars=3D'  LVM2_LV_NAME=3D'\''almalinux8_opt'\'' LVM2_VG_NAME=3D'\''ro=
otvol_tmp'\'' LVM2_LV_ROLE=3D'\''public'\'''
+ eval '  LVM2_LV_NAME=3D'\''almalinux8_opt'\'' LVM2_VG_NAME=3D'\''rootvol_=
tmp'\'' LVM2_LV_ROLE=3D'\''public'\'''
++ LVM2_LV_NAME=3Dalmalinux8_opt
++ LVM2_VG_NAME=3Drootvol_tmp
++ LVM2_LV_ROLE=3Dpublic
+ '[' -z rootvol_tmp ']'
+ '[' -z almalinux8_opt ']'
+ echo public
+ grep -q snapshot
++ date +%Y%m%d%H%M%S
+ start_time=3D20240104091039
+ snap=3Dalmalinux8_opt.e2scrub
+ snap_dev=3D/dev/rootvol_tmp/almalinux8_opt.e2scrub
+ '[' 0 -gt 0 ']'
+ setup
++ date +%s
+ lvremove_deadline=3D1704377469
+ lvremove -f rootvol_tmp/almalinux8_opt.e2scrub
+ '[' -e /dev/rootvol_tmp/almalinux8_opt.e2scrub ']'
+ '[' -e /dev/rootvol_tmp/almalinux8_opt.e2scrub ']'
+ lvcreate -s -L 256m -n almalinux8_opt.e2scrub rootvol_tmp/almalinux8_opt
  Logical volume "almalinux8_opt.e2scrub" created.
+ '[' 0 -ne 0 ']'
+ udevadm settle
+ return 0
+ trap 'teardown; exit 1' EXIT INT QUIT TERM
+ check
+ E2FSCK_FIXES_ONLY=3D1
+ export E2FSCK_FIXES_ONLY
+ /usr/sbin/e2fsck -E journal_only -p /dev/rootvol_tmp/almalinux8_opt.e2scr=
ub
+ /usr/sbin/e2fsck -f -y /dev/rootvol_tmp/almalinux8_opt.e2scrub
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/rootvol_tmp/almalinux8_opt.e2scrub: 1698/178816 files (87.0% non-conti=
guous), 482473/716800 blocks
+ case "$?" in
++ lvs -o lv_snapshot_invalid --noheadings /dev/rootvol_tmp/almalinux8_opt.=
e2scrub
++ awk '{print $1}'
+ is_invalid=3D
+ '[' -n '' ']'
+ echo '/dev/rootvol_tmp/almalinux8_opt: Scrub FAILED due to corruption!  U=
nmount and run e2fsck -y.'
/dev/rootvol_tmp/almalinux8_opt: Scrub FAILED due to corruption!  Unmount a=
nd run e2fsck -y.
+ mark_corrupt
+ /usr/sbin/tune2fs -E force_fsck /dev/rootvol_tmp/almalinux8_opt
tune2fs 1.47.0 (5-Feb-2023)
Setting filesystem error flag to force fsck.
+ ret=3D6
+ teardown
+ lvremove -f rootvol_tmp/almalinux8_opt.e2scrub
  Logical volume "almalinux8_opt.e2scrub" successfully removed.
+ '[' -e /dev/rootvol_tmp/almalinux8_opt.e2scrub ']'
+ trap '' EXIT
+ exitcode 6
+ ret=3D6
+ '[' -n '' -a 6 -ne 0 ']'
+ exit 6

Cheers,
b.


--=-CgMbNShrDZ/cRDUuSB4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAmWWvSEACgkQ2sHQNBbL
yKDbOwgAhLbyDzMGseeAizrXpL6d0DYqpfD3rC80v78pb7eMjJqP3NGp2FTDuw/O
4lwDCP7kUZZuef3K0t85vu/zYm4CIwsRY1jqoV/fhzHxwBh+iWeO50fVJ/MORc8R
/gBLEcrOmeeGJOXm4BABPPXlyGLqv9ZizCpeZW7CIIZZkOBBWc+cQMxa2c1HEMec
8NHwdNZYkNJNE71UJkc3Q2PNiRRoN6jaJyrs7eq6uTSBNdUHSuiDoVxhh/L8ha7a
9OBRZ9/6/JlTbsl8CS5Og6iNVVabGon4VSffmvUwV9TvcE1VZ0ZIDQXx3F03ZyHW
n1rpNHs0JxW0TS34hntihZVF3qmsdA==
=PlIx
-----END PGP SIGNATURE-----

--=-CgMbNShrDZ/cRDUuSB4B--

