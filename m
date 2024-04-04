Return-Path: <linux-ext4+bounces-1868-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE535898D28
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC61F2B36A
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615812D1ED;
	Thu,  4 Apr 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="Z76aXnwE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342ED12B95
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251534; cv=none; b=WJZfN4IMjeUK3zSV+bGH2CrmLMPcYODYTHbGSbwGDthscVHJxzmCRCI33JwxGUh9Du+RQq21Xzpo0xnDeyLrhBPC3t/kdtkGtADBBbsLgJD2O0c/0/Khc9Q12pSVjZBPdE1Tx81gdU1ZQOeMeeSPFRL1kGFdlQpb5Ucu23HUAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251534; c=relaxed/simple;
	bh=K4g7/cCYNTpi4SRnDfwUi9VH7/1ep2QvxvppkCtWBKo=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=uEd8FlypjjGXPuRSg7tD3zFf1g7Sk7kc1/JMPbY8JpIfKA4Xo4uASOty45HNjoBUzhgqhHmcR/oV18x8Z566obKryo06vWTnLbt0sQ3O8Viv1v9UEEiar0pbT0johjtbRCOTL4m08Wg5EJErEXeFh8Led6FpJoYXeFyjpNTCvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=Z76aXnwE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b22af648so1880230b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712251530; x=1712856330; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiLvuY4QOIIDPL9YOE++fLzdzL/MQBb3M4dFQBp+OY=;
        b=Z76aXnwE5jjiuY+OPr1XGAm17ahwdmnFTt77aVxbcAKXt5dcPCUVHu+vjHhenTxuho
         p+S0Yh12LmdrI68ANqNaNU7in+/JOCJ072kkOgUDb+8/7FguJmYlNDBN37l/7IHP0tK7
         gpU1lRpQBbeGU9RNH7DMZtrwSOYDKuyhKjAyb7ERmWgnycbPjw3ETltdhxqSNLoPMMQ4
         UakP9DRqvM8F6Zezlikco0JSr7EU07OsxdXe/ST/vEV+S8jeAiSY6MnwsJLm1Tl/DdnL
         MiXEPqWpoxJQfan9KXhKE85b6dGgik63Ky2RhaHYw6KtdHWGxvItJUN+9i6wLU/EjkZR
         fNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251530; x=1712856330;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiLvuY4QOIIDPL9YOE++fLzdzL/MQBb3M4dFQBp+OY=;
        b=aoVIneb9wSvOtaS6bQLyE3UhsxAA8Q0LNNeux97AX89Zjo7ogtX4ot9hqH4JLcHwQt
         wG33eC8/rj4q5J9DP8bCCFF0c2PTp71amc8KcGBG45E5MYYc/mT9zsJ4ko/TKucvEM2g
         EuaM78NKmr2ab3FFMkumPwMTwS4zvmlufB/l1mSLQnkMU4a1Hrp2R6H2zyPZnRfNejOz
         a4vKQTQVKOLs0NuVDQAD91BqpN2C/h5bTJnidPZB+YSuE6DZcrMHaL9P4FJEz300u4Fg
         AYzs25NLUfJdGoyG768MZlJvOR2CqWPItmYhUpukzyfp5kM+9gxTvNXO3wUALL+agbAo
         FPkg==
X-Forwarded-Encrypted: i=1; AJvYcCWEh7Ez/fC4CgX4xUl2oc2Q8i4E6h67t8iYo5qfvdiXWkg4mCs53VHUgTlkz5gMXdHFbSbP2Vz6yHg3vCJgpxY23pC0Aw4VYU/pDw==
X-Gm-Message-State: AOJu0Yyb2VU50zcVyVVzE6pcm5Od/nTASz/7ObHjEK1tHP/u+GdKHpIR
	gyyjdYjJqaQpsTWAlH8EuJv/GODN4zHIOEUc6yzcLfxMXhka+HUvLJ+ufXrldK2b/aVl9UqheT6
	6
X-Google-Smtp-Source: AGHT+IGUL5lc8CAKLrTHA53YT4gjZeHPev4LA0EXgo3HX5mUkzNb4+vq/HbbCD9ADEdJSIhUcg35MA==
X-Received: by 2002:a05:6a21:788e:b0:1a3:c4a0:130b with SMTP id bf14-20020a056a21788e00b001a3c4a0130bmr204935pzc.5.1712251530284;
        Thu, 04 Apr 2024 10:25:30 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id t24-20020a63eb18000000b005eb4d24e809sm13904425pgh.34.2024.04.04.10.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:25:29 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <061163AE-5CBD-4714-AE75-0FEAB9FEC002@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FD4ECDA5-9A40-4155-B50E-D02C8D23D91D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/4] tests: new test to check quota after a bad inode
 deallocation
Date: Thu, 4 Apr 2024 11:27:33 -0600
In-Reply-To: <20240404111032.10427-5-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240404111032.10427-1-luis.henriques@linux.dev>
 <20240404111032.10427-5-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_FD4ECDA5-9A40-4155-B50E-D02C8D23D91D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 4, 2024, at 5:10 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> This new test validates e2fsck by verifying that quota is updated =
after a bad
> inode is deallocated.  It mimics fstest ext4/019 by including a =
filesystem image
> where a symbolic link was created to an existing file, using a long =
symlink
> name.  This symbolic link was then wiped with:
>=20
>  # debugfs -w -R 'zap -f /testlink 0' f_testnew/image
>=20
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

After your explanation in the previous version of this patch, I now =
understand
that this is fixing e2fsck so that it only reports the quota =
inconsistency in
the first e2fsck run, and not the second e2fsck run (as it had =
previously).

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> tests/f_quota_deallocate_inode/expect.1 |  18 ++++++++++++++++++
> tests/f_quota_deallocate_inode/expect.2 |   7 +++++++
> tests/f_quota_deallocate_inode/image.gz | Bin 0 -> 11594 bytes
> tests/f_quota_deallocate_inode/name     |   1 +
> 4 files changed, 26 insertions(+)
> create mode 100644 tests/f_quota_deallocate_inode/expect.1
> create mode 100644 tests/f_quota_deallocate_inode/expect.2
> create mode 100644 tests/f_quota_deallocate_inode/image.gz
> create mode 100644 tests/f_quota_deallocate_inode/name
>=20
> diff --git a/tests/f_quota_deallocate_inode/expect.1 =
b/tests/f_quota_deallocate_inode/expect.1
> new file mode 100644
> index 000000000000..2b2f128dbb57
> --- /dev/null
> +++ b/tests/f_quota_deallocate_inode/expect.1
> @@ -0,0 +1,18 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Symlink /testlink (inode #14) is invalid.
> +Clear? yes
> +
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +[QUOTA WARNING] Usage inconsistent for ID 0:actual (15360, 4) !=3D =
expected (16384, 5)
> +Update quota info for quota type 0? yes
> +
> +[QUOTA WARNING] Usage inconsistent for ID 0:actual (15360, 4) !=3D =
expected (16384, 5)
> +Update quota info for quota type 1? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 13/256 files (15.4% non-contiguous), 1157/8192 blocks
> +Exit status is 1
> diff --git a/tests/f_quota_deallocate_inode/expect.2 =
b/tests/f_quota_deallocate_inode/expect.2
> new file mode 100644
> index 000000000000..802317949959
> --- /dev/null
> +++ b/tests/f_quota_deallocate_inode/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 13/256 files (15.4% non-contiguous), 1157/8192 blocks
> +Exit status is 0
> diff --git a/tests/f_quota_deallocate_inode/image.gz =
b/tests/f_quota_deallocate_inode/image.gz
> new file mode 100644
> index =
0000000000000000000000000000000000000000..798a72c3a0da0323fc55c5e034f778e9=
67394c81
> GIT binary patch
> literal 11594
> zcmeI%eNYqUx&UyiRgMQsPLKCM5rNy&@i@JTaO(gyn54Bwu%aS@KoXLGC`cj%3rjQ*
> zg2hU`eAU`Q6+=3D`M67t1|OCTYMNYyF=3DB1u;HiWUXBD+!3pM<Bb`+nL^fZpZWAnK|C<
> zpU=3DB9@B9At*>|63*0<;ne|Yru^5mt<QqvMs4lQ{;=3DyG8#(4PN9*SUP@$xXViE`Pne
> zK0NZ1cQ*uWjI00T&$OjGws9}5lt>bmzrFo=3D{>8rrML%Ee8uX`}&l>)HyIhiM`?l!8
> zzr9U)`^DDT9B%VE?Pm3~_)+VS*Q)$^^N!t~t4cW<+s=3Daa??*fw9p6o9CU1POevfa^
> zM=3Dhi06`Q<TXR<xAFb!_H|JRX}p!APutBE?Jrw3Os_l&O0`{~@6H}6N!s8ZdNjyUej
> zy&-dDYv=3DQUpv|(O@oztewg~QC=3Du5T=3DZj8EA9W%S9i1~xR6qUSe`CAz)_(IuGWp~|^=

> zf``>Javj^&Upu34uyNu=3DH+g|lU0?oQys&q7E7rKEE_>OXx~;@y{7=3D~fQSTZsSrM3<
> zr^-4+iJ<IQ^7?C(0u8or#C*xvyOeD$;Ani)9T6vY36?Xe81q=3DW<*2=3DFwDzsZ2VM4{
> zARgwwmTL`6D(IaWSXCQ^i><<)qRj$Fbz#@SmO-Uge!)WXVnW7~l2PHofL2?0u_awq
> z-iv{}iKqp0UJ@>vHz-|g7pH}vO!Iem$GMm;5a%`p;P=3DKt@;k<Gds0%c4<5Fna`+a$
> zuwDK0JWlb%X`Ng)=3D27*sXJCTa#Lk|G%yGN@W50GrD&QFUg&)TlPXPCS@)ly}45E-h
> zoQl`X;Gu<;H-$gMbZlr=3Dd9!c#OS6@pflb*`21h+m@6hVR`1A~(-sbSt4P%x|>O{Js
> zYvyd;lx-AW9N|?0X*pKI!X#GMH^9Lx59Wf8XY?&ls-Z2nf*P+Y3}vzia_Up}E+HcX
> z-_2Ezh}RQVRP1V*pQk(zT3jrnPD>`z?_hZS6Gu;u-|O99KbjF1Ks)R5K{bMnyc{3b
> zh^SZkcwQT~5|bcmlZ_;RNZIFzZRr7V2kNhn%Sp{5&4{(2{eTF6dGd4D?y4ZpOtClb
> z(W3_^Ln^kX*JG@}M5~=3D}Z~d)}OY5;^X5n=3D^Ar5~Fp(Hq5<aj>n`)lxV_kkO8e+p=3DD=

> zmn`S(^NV&Rj0!>%0^+g)W;auc2&cr$)~qU*UuFN&KH0Rbp#3B8h+k|c^hfZ3B6<V#
> zA0S&16U7FKe6ZT?p~D3bo=3DHeJGJNOE)RV`d<;0Pn6$C?Wr-`s-x^1NN<D|O{BWm4;
> z;c=3DRb+Bm!rnVcLEa<HPxlJ2x4hN)lLM=3DFMray7T+o)wmgS)5!VkgJ)Q%UaC4<>qAp
> zmtcj;M^BTLF4ji#dzNuR@WTaV*0Y2!3r+-BJX_Bp>oM7eAn^ICEnXMhX{|)l9PN+4
> zeD$)5p+Qcl%HeI@+Q&Y2a|ZluA}+)<Sw`-boCCurXj+HMEalmXG5k2LE(<T5wuBG6
> zYAwgRD)HX-wy1*kOX??wrh*0{>^BXS_;i^i%?wVo;?|A@-#xGLK*$Ry!YgL!`NGuh
> zNdYMsofQ_^(AI-DuAF&dnGxwnic{VHG6)PE!?{=3Dh7q@-sHG!8fxHuQa`y7N>y!)IU
> z>+Qfi77UrEY)|8`ni*l(Eqr((J_jtGQRz71e)Wvkg6$p-Fpjy1@MY(r&*1As$*8fN
> zcVd2a7Ei>`@`5oX6dZ_^FvkLCep;%=3D$V&43l{56L#cCx9>wTFWf*pM^33PY$;EC!)
> zIVHKPx>>t!08i{#5Uc%{;1;(v)@7!Q;PG$P=3DuhzGMh82Po50__sbQvY_$u1ChWsgu
> zsglIHiAMq#1Fp+p6MCMXrc<8c29TAds@3p2zyVP-S021y_T+IFa5rODo!UGAPoSmz
> z6rF63q7Qz_=3DZPXy%sH?Q)e~jItQ5!vE<i8YGXw`)^rkQ*37sOU$&q4t#5=3DR8@MiRp
> zJzk*K?`6rS;c)bseWw8UIL`#Z2wGxK7I0epDQjbq0U%OPtEXFJHi!ThqSf}Jjw^XI
> zimV733*4HK`?;erZ@)olS;bNtxk#g?O)1%c@PPdeJ+@aUr<lZue@8<LMia^mgxiLx
> zx6-eKa$cRHKhiF`%RdMA`o$L+pVF?m%WiT`(;Ca`t|IB+E<bvw=3D>@n=3D5x2o~7u>0!
> z$xPqTbY@8)N1@3Xsx~Wg%tSz?;SJSV>4=3D#R<_)Q=3DEP}+vTmZMD-|!Eo?e#K;f=3D5Ym=

> zA7-Vo2BeZM`%o*PYIYGni&W!7FO%JdR<k?#2T0PY_y}pOIR?GP=3DaZ_dsC1|aeuQ4&
> zr>8~r$i^U7_$x3iEjEfn+pU`56!te{*NHfxU2+B+>Q^wMwUGQgBga?;#!fI6jCznY
> z!E!O4_+Z3K9klKCJO1=3Dk>vZzdQ(lq}GyN~91#3OyGrM9cO5$_0h@L5$wYhsznx+!0
> zV=3DD`Lq?L1n_fdIp&S*N)HF#(y&8sU$+q>?pGSmLumfEhtg_B)`ty6NpZZg`^=3Dix;j
> zThAJsyFFR4sl&VM*ALfPy;bpR2A}fHe<+;e*SoDP6+`s6@WF%u^0Q6&!s+8;ZxNhU
> z&D)76$2u!iS{UkbVCjp~!V$4ed#EO2>x&zp7#;2_smd737NNo$!bVKBIs0a6xzFoQ
> z(KmVY9&5CC)e4s~w-trE>Nh6jWo97w`@muEm_n!s`I^{RT32BVM-Bm5x;AE{N}dEi
> z<nPyMm{BSPWI~V@qJEDg*mxS)r)wCFUJq3w-|@qB;BX9A#WRK=3D41g_)sfDyiF|lbl
> z%BGk#QBjPjCGYi>6HJB32f!Y|HFAuvDic|a-mymuG~_6;qQ^9bxS}_SDt$CdsWQeQ
> zi*}kor;oJAxu)enqCmT;&SvBxIjF<_siQtGnxYgNBajr}sG}_}vcl+(#G;6OH-lzS
> zbiyw*mz8phX+OGP|IE>VMGKV%qX~uVbcaqU{d5G|QDQ#1Ms^zf#4qkF`x33iU3v#R
> z>=3D#o6{TV#yw?7;jVxOZmm&=3D}UzM?h6)P2wSo(9IqJ_PxSNRF8X%xc0Ej9EDVGXa|>
> zVn}UPplpYRHDvJFOOU&m3Xu2F`~4S#<R$D8ejKSSNV=3DQT#Q!^~F-R3=3Da!1GcyGYGG
> zv1O|D#&YyW{ytJ`)xHRY0!~F=3D@<T~Y&B_#06S4&z?60Yc?NNCcT{#2&${O>v^UMLr
> z4NRJd4uOi#Q?*7VNY_cSRn$Q3jD*Bd{Z`c&+$778i|0497ni-s`TGy|mj3*k-uB1$
> ziE=3DlU2lOs*(0jkXw8Gp8kMob~E;FgOjSXlWAJEk>=3D_(ln9R+eld%2R;$Q6E)PP#`K
> z41I`}^Eo=3DjFw-XCnYFNysMw?8L7qUeu6CGilQqE(AX{*e9Oqj{fWqJl_QL`>nK@=3D&
> z51&P)_AEgSnJ$*~Kpt=3Drz!XUJ@hqvzJdc8QzMxu9wbZ%7H|*JrXp7Wlo`o0C0(+uE
> zk{3^rip@Rn&-UYv%bTPuvkHdLO3k%AdWGp3u$@6Q$Yk&=3DT4+ylNU?aKREDTfwLOOs
> zRj{(4{mswlD3^!;?5%(J+~4FIg0sg@wm+^XwlU+wjAwvo-4!OyUsjDgL;s6^$UEw`
> z`G4ywChN9o3fQK*v`2mxE<tOEt;6xPMmnrOoB27q>S3y_E(*Cu)D1IIjOWlQK3Ave
> zuA7A(p(pGK0tq?ZSDFb|qYd_BBDz=3D-VXlSy&~x@90wtNnlK7jCqgU-;2(IdBW6*CE
> zm28v5^>y_WTBNy>M>W*3ATIpCp2mo&fc^p;awwH`7RVPaLu>7sj;l(g!EAwT!0vZ$
> zttdFNMzJz5W;N#ot^RMOZD5AqzO$TOn%rHrj(vw#SFY5Wez%E0Y1L*q2wQ<Nn$}81
> zj5>H25No&!I%2W|291z((I<{j=3Dklroz65@n7UyNUh1T<rrR}RUC!=3D5U52i88>ipnd
> z^auVClG2A2A@M^_qgVJ}kgitI=3D%zmS7qpn4oW|&>OMx=3DsR&X~-RmJj`c$k|(#%@Jw
> zpzi;4jr_>pTF+9?o;Nu;e|K;BA^LT(A+wjy)MN(5kN2N)f6tJ9`Q|cS>gtV4f8dr-
> z-wv=3DemJx~v`;Q)o>U6WpL;YTb6}m4+@BqUXi@u|*QoLialT3a*N4Y0lix<vAPdQ$m
> z3|{WWAGW^d%}{SH%C>*I@@!~wL}g%(y>xR8b>Hu<!x{W12wZpTOTPCIxXaX9$w}~y
> z@)iGtIh|8D1)Ks-0jGddz$xGqa0)mDoB~b(r+`zyDc}@v3OEIv0!{&^fK%XKNMKSp
> k(f<Db{OruXh^uso|3WKwF7^L|z}z2?A5?k2O3x+#4eAK~X#fBK
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/f_quota_deallocate_inode/name =
b/tests/f_quota_deallocate_inode/name
> new file mode 100644
> index 000000000000..396887c16f84
> --- /dev/null
> +++ b/tests/f_quota_deallocate_inode/name
> @@ -0,0 +1 @@
> +update quota when deallocating bad inode


Cheers, Andreas






--Apple-Mail=_FD4ECDA5-9A40-4155-B50E-D02C8D23D91D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYO4wUACgkQcqXauRfM
H+Duiw/+MfSNz3PtIrHIzaQS3WVHeLk/ddeMOc4umBVSzq3bp450r/Sm5rAbDQaL
FZZ1yK/KfSC1H4K8px7TesLMozdgnXVZsmCfIWn37gEd+tzrbFuKx+/As0GIbBIe
0A0zZ6hztjBDXZKc00i3LxtsQoj/lFQs2tvtFMwqQ95/U2h6QfU53DOB7fJQQwyX
W0BiEFvuy92VXbNeqXyriGRQ4F5lziW732Ax61LYoUhYC+QG4aN8XNS7pYNNrvfG
FFUY53LtDVZ13XPhmImt3VzFy22SSACwrAsRBaZZAsa1G8bnS+0eP22Gu1Lg2f0Z
HUCLiUB392vmJ2DhzTSSBE6gbzqMOYPzz95KqIS5DkqmU10axDzEsYENr73o/mxH
GznvczpVUfqqePEl8bvbl+GDF1HRP60GFEQ723eZU8RImXnlNcEIF5XM5GthusVY
pffOKk42iDtog6oT/Ha+T4XeG8FFlcXYxGLoY2vvhyGIG6CeH9inbfBN2uT0hyrA
pErkv+MuGAsHMgk+xtfbEbEXlDyEwVJkkarW+v5NjDjc2/N14KpTfikfQPfIcx5w
65UcRX/I+nWAbGCPkqleir7YvRz/6AuwfiybWwxzwDiLCHapsp6sUJD+1KoabmsA
8mu7zOLeODA5tbAYOcXsLcgO/4WsmhrbOnirjITlqmzb63v4dTk=
=AOxm
-----END PGP SIGNATURE-----

--Apple-Mail=_FD4ECDA5-9A40-4155-B50E-D02C8D23D91D--

