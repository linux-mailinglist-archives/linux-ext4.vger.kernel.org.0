Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A620DC36
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgF2UNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 16:13:09 -0400
Received: from mout.web.de ([212.227.15.14]:58117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbgF2UNG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jun 2020 16:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593461583;
        bh=Q3WSo3iqrFbKXC7DLY/3is3L/ZI6GDoUzruhP1cV/to=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SaS/sbLk0BNHnhgxU7MvVPkBupbfR7gkvP6+7UTp/1mOc7lHZyZLgywkSM4pnWHAC
         cK2+z/uv9pgso7PYPoA3S/pOLF+2onbEJP5JxYNkQKR42haHi4zN67QjlSorJoz5Df
         m5H5lFqOOI252929tikgCVKHjZ3q0eJzHjJxtYPU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.123.16]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3jsn-1iyeT42K25-00rJzV; Mon, 29
 Jun 2020 08:26:51 +0200
Subject: Re: [PATCH v2] ext4: fix direct I/O read error
To:     Jiang Ying <jiangying8582@126.com>,
        Wang Long <wanglong19@meituan.com>, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
References: <1593400165-114818-1-git-send-email-jiangying8582@126.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <22f650fd-6348-30d8-763a-8e03b0772f10@web.de>
Date:   Mon, 29 Jun 2020 08:26:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593400165-114818-1-git-send-email-jiangying8582@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6DkxKtQCaX1WqVxtxjIC4UtI3gb108ulowLy+O6ULPizOMczSQ8
 QIl3o8HtDNZOXTAv33a7BioAOPjwf6CnT/K51Z016trMu2u0X5E5bgQIdM8O6XGEAfIVFDe
 FRXkN6lQ1y3dgUJvS/VOnOce/Y/8Wbmha/09jbPW3KE1gslmkiJL+BKSfiyJqHi7ULObV1k
 AJtZ50k3KIB1bWn5u6Dqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q6hm88/EICM=:+o2JQ5iJKVKQP26hXF8s1p
 LZLXY+aUxMpPQRHSVpJrQszqhO4jw73NajznJpHPzXIhSnHwmkPeZxwVYcenKkPEqNtyKcesq
 dFhw30Lkb6rrRGYJQyVMBOP1D7ej5jKKBedo3ybj5ml8qjuzys8I1zyQ/g5BpF4UR9YywNnjJ
 RTkdErAQUYMZJ0VBxvATHd9HB5mxb6fTUJIO7Q2U2VVFySLMsQzdW5hcWRY5MD2Khucezmiux
 iYTFyaLoanWZ6ywz6+XBy10RsVX38wU6SoPhCUk6nWod6LwvsZh+7fPyzWd8TyR2in+W71vNe
 aP+gafLNF7Rg2DIz6Xz7Ap6F+N3iwadkBQPI2npaX2bk9gmxGJeBfnFwS7dylpGO+0qQadNeT
 NB1I9ETQtfjOQ8qvzXD2VC/onNZ+CnnsHubQ4N3c8rT0BTgZqC3b8JY1uap9JYK9THI7gpxkd
 AcZOsutIqHIBCIEp6TOPBLxLie1zoStEu+OmetYIAx3B+Ba8xHoMmieih+H7v3L0dxMb5dXAG
 uh85/1lLdyiXy1se/6snhoZk/zYDbDKZwWL2hGdWllbusTgoD4eNi0MlJNhHigZmqeGhCGPHB
 xHyu2GcpGnbKGBw0VepN7rpFpMPzWKBhyed+/xFmh9+YSzhqa9u0kl1JeH1GVw5TMx2O7S6tj
 l/xoh7Gx9T/HQryvNuy6CEfhVZW49qJK/EkT666ut/pnQPWZMRbAVsdonrOn+Gswp+3BvB/ll
 0ObkNmlBIuFHHvgT76IcnMbsic3QwMtknRQYu1cjW39PlOjr35f33EkFLWmZER9zHBMZB4d6F
 nZcp2lhAslH6UX0wK8jgsNf/cwVxx4PleBVVJgn8Rjhxa/zUFDkooj6K0cpWHwdx3UhAHoah8
 fSnlUIIfTBT1bFdA5nyOtJo8eMzh9imNw6f4Domtpcj6ijY/HqqAyFPi60dm4URZBMMbpf829
 4Cp05bJ6fI0RhYt/w3KRC6LcqIqcia1v/U9MTtgEK12Yypl2fxGqAsIHBcW102eIMJB8EXmC7
 W0RBksweVBpTCqGGtUKKJKlE5UFLlEPypfryL7jQ2VDpeZ1q5bn/jITJT7Nvfn6NRxPFgspsK
 RsYsuLiXmtIfwBDwYDtpfMeuXfhvDKR3JGOyC4BxaunzQBj/siDDHScNx+PvcC/r1BCNlhEeF
 qnYTfEwcPOy8aa9yWmh+cvwKe5AxfCatG8TQJeXAtil4Vxzzua8FA7oWjzc1FB4PoNkZ2x5gt
 shmMrCnkkGDyM5Xv9CHedH1iZDY7ybU9tw2LFkA==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Fixes: 9fe55eea7e4b ("Fix race when checking i_size on direct i/o read")=
.

* I suggest to move this tag to the bottom of the commit message.

* This specification is usually preferred without a dot at the line end.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D9ebcfadb0610322ac537dd7aa5=
d9cbc2b2894c68#n183


> This commit caused ext4 direct I/O read error when the read size is not
> alignment with block size.

Wording alternative:
aligned =E2=80=A6


> (1) Make the file that is not alignment with block size:

=E2=80=A6 a file =E2=80=A6 aligned =E2=80=A6


> (3) Compiling the script:

(3) Compile the source file:


> (4) Exec the script:

(4) Run the test program:


> =E2=80=A6 Thanks.

I propose to omit this word here.


> ---
>  fs/ext4/inode.c | 6 ++++++

Would you like to add patch version descriptions here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D9ebcfadb0610322ac537dd7aa5=
d9cbc2b2894c68#n751


=E2=80=A6
> @@ -3821,6 +3821,12 @@ static ssize_t ext4_direct_IO_read(struct kiocb *=
iocb, struct iov_iter *iter)
>  	struct inode *inode =3D mapping->host;
>  	size_t count =3D iov_iter_count(iter);
>  	ssize_t ret;
> +	loff_t offset =3D iocb->ki_pos;
> +	loff_t size;
> +
> +	size =3D i_size_read(inode);

How do you think about to use the following source code variant?

+	loff_t size =3D i_size_read(inode);


> +	if (offset >=3D size)
> +		return 0;

Will any further fine-tuning matter for this function implementation?

Regards,
Markus
