Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C414C5FE
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfFTELP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 00:11:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfFTELO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 00:11:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so893436pfc.1;
        Wed, 19 Jun 2019 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=CDAbnVHof/kwgRHwGfbnSMy3X4g+ZuSI9nXInlnWgrc=;
        b=T1fucym5y8I+JFOBMszbYCSrGzAZyIgq2gFbGfwWyit3fKk4LH9liImksY2m0a3h4C
         TgDlCHY27WezFIbTevduZm3lnbTp7CKgV2k0B4bUmP49X11ko1r9f6bEin7Liu99gujY
         tSpLeSK42g4ffJX6N7da6NXF8KodZ5xa57yk2l1qcv9c/Z5fH0V91+3u4wSM+25hHfu+
         j+c/k+OsmgS0uVavDnOWQMbR5bkZNghZl3NM7MzrR0lCssUZvIOj/oYbpzRWzAuFPI1/
         r0nNSNgmpMDod6nN0OdWCQFkLVsn3wYH6An8o5ujYoTzrHjmm8CEDYVTYDwcrc2UzEAA
         gbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=CDAbnVHof/kwgRHwGfbnSMy3X4g+ZuSI9nXInlnWgrc=;
        b=iauved3OdHpEfZbRhIWowgFuWwFXeJ+Qkvq90NVtrzO+kQZooAduEOekkBK8elWxbK
         bemtzEkpTfU0i13qphS3bBuc//gDmdrQ9DXMiezfR3oqOLqkNnZfiNqnDkZwp5Kli13F
         E4qHnyN8zHKFjbPDffBVixsCbspWI25PZ9F002Nu6RPUsr4YuKSiTILSaYN+tR6OHZfe
         WAAcnzNSC1u5u5gAKV957pLksCj7wdVqd3aOvVjoyble7MkK9zMNfnuk1wab2a7VYVDm
         WBtXLup9/RAUlpyi4+obLWeDw78OQIttLxLpJkBPG5sas3S7+GX9K021vuOAy4ViFqND
         Cy5A==
X-Gm-Message-State: APjAAAUvAdqTHQChPMro8PQSIOTOiN5yAB3S3i+ZC8nToVQssWiUjVer
        oGtGmb5awNCEHWk9MuV4cEL3DKCZsB47vA==
X-Google-Smtp-Source: APXvYqyXyWM48x2RgA1+TGWJUXfGmqc271a9GHi7C0ofw+1wIws05RcI0KOUttyQSOcTKDpKRti7WQ==
X-Received: by 2002:a62:b40f:: with SMTP id h15mr120111484pfn.57.1561003873682;
        Wed, 19 Jun 2019 21:11:13 -0700 (PDT)
Received: from [192.168.193.4] ([65.153.196.167])
        by smtp.gmail.com with ESMTPSA id q63sm14697220pfb.81.2019.06.19.21.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 21:11:12 -0700 (PDT)
From:   Zhangjs Jinshui <leozhangjs@gmail.com>
Content-Type: text/plain;
        charset=gb2312
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] ext4: make __ext4_get_inode_loc plug
Date:   Wed, 19 Jun 2019 20:29:16 +0800
References: <20190617155712.51339-1-leozhangjs@gmail.com>
 <20190619110836.GC32409@quack2.suse.cz>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190619110836.GC32409@quack2.suse.cz>
Message-Id: <7587EA17-7819-4A1D-8631-FFC839B07308@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> =D4=DA 2019=C4=EA6=D4=C219=C8=D5=A3=AC19:08=A3=ACJan Kara =
<jack@suse.cz> =D0=B4=B5=C0=A3=BA
>=20
> On Mon 17-06-19 23:57:12, jinshui zhang wrote:
>> From: zhangjs <zachary@baishancloud.com>
>>=20
>> If the task is unplugged when called, the inode_readahead_blks may =
not be merged,=20
>> these will cause small pieces of io, It should be plugged.
>>=20
>> Signed-off-by: zhangjs <zachary@baishancloud.com>
>=20
> Out of curiosity, on which path do you see __ext4_get_inode_loc() =
being
> called without IO already plugged?
>=20
> Otherwise the patch looks good to me. You can add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> 								Honza
>=20
>> ---
>> fs/ext4/inode.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>=20
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index c7f77c6..8fe046b 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4570,6 +4570,7 @@ static int __ext4_get_inode_loc(struct inode =
*inode,
>> 	struct buffer_head	*bh;
>> 	struct super_block	*sb =3D inode->i_sb;
>> 	ext4_fsblk_t		block;
>> +	struct blk_plug		plug;
>> 	int			inodes_per_block, inode_offset;
>>=20
>> 	iloc->bh =3D NULL;
>> @@ -4654,6 +4655,8 @@ static int __ext4_get_inode_loc(struct inode =
*inode,
>> 		}
>>=20
>> make_io:
>> +		blk_start_plug(&plug);
>> +
>> 		/*
>> 		 * If we need to do any I/O, try to pre-readahead extra
>> 		 * blocks from the inode table.
>> @@ -4688,6 +4691,9 @@ static int __ext4_get_inode_loc(struct inode =
*inode,
>> 		get_bh(bh);
>> 		bh->b_end_io =3D end_buffer_read_sync;
>> 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
>> +
>> +		blk_finish_plug(&plug);
>> +
>> 		wait_on_buffer(bh);
>> 		if (!buffer_uptodate(bh)) {
>> 			EXT4_ERROR_INODE_BLOCK(inode, block,
>> --=20
>> 1.8.3.1
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

You can blktrace

  8,80  31       11     0.296373038 2885275  Q  RA 8279571464 + 8 [xxxx]
  8,80  31       12     0.296374017 2885275  G  RA 8279571464 + 8 [xxxx]
  8,80  31       13     0.296375468 2885275  I  RA 8279571464 + 8 [xxxx]
  8,80  31       14     0.296382099  3886  D  RA 8279571464 + 8 =
[kworker/31:1H]
  8,80  31       15     0.296391907 2885275  Q  RA 8279571472 + 8 [xxxx]
  8,80  31       16     0.296392275 2885275  G  RA 8279571472 + 8 [xxxx]
  8,80  31       17     0.296393305 2885275  I  RA 8279571472 + 8 [xxxx]
  8,80  31       18     0.296395844  3886  D  RA 8279571472 + 8 =
[kworker/31:1H]
  8,80  31       19     0.296399685 2885275  Q  RA 8279571480 + 8 [xxxx]
  8,80  31       20     0.296400025 2885275  G  RA 8279571480 + 8 [xxxx]
  8,80  31       21     0.296401232 2885275  I  RA 8279571480 + 8 [xxxx]
  8,80  31       22     0.296403422  3886  D  RA 8279571480 + 8 =
[kworker/31:1H]
  8,80  31       23     0.296407375 2885275  Q  RA 8279571488 + 8 [xxxx]
  8,80  31       24     0.296407721 2885275  G  RA 8279571488 + 8 [xxxx]
  8,80  31       25     0.296408904 2885275  I  RA 8279571488 + 8 [xxxx]
  8,80  31       26     0.296411127  3886  D  RA 8279571488 + 8 =
[kworker/31:1H]
  8,80  31       27     0.296414779 2885275  Q  RA 8279571496 + 8 [xxxx]
  8,80  31       28     0.296415119 2885275  G  RA 8279571496 + 8 [xxxx]
  8,80  31       29     0.296415744 2885275  I  RA 8279571496 + 8 [xxxx]
  8,80  31       30     0.296417779  3886  D  RA 8279571496 + 8 =
[kworker/31:1H]

these RA io were caused by ext4_inode_readahead_blks, there are all not =
merged becourse of the unplugged state.
the backtrace shows below, was traced by systemtap ioblock.request =
filtered by "opf & 1 << 19"

 0xffffffff8136fb20 : generic_make_request+0x0/0x2f0 [kernel]
 0xffffffff8136fe7e : submit_bio+0x6e/0x130 [kernel]
 0xffffffff812971e6 : submit_bh_wbc+0x156/0x190 [kernel]
 0xffffffff81297bca : ll_rw_block+0x6a/0xb0 [kernel]
 0xffffffff81297cc0 : __breadahead+0x40/0x70 [kernel]
 0xffffffffa0392c9a : __ext4_get_inode_loc+0x37a/0x3d0 [ext4]
 0xffffffffa0396a6c : ext4_iget+0x8c/0xc00 [ext4]
 0xffffffffa03ad98a : ext4_lookup+0xca/0x1d0 [ext4]
 0xffffffff8126b814 : path_openat+0xcb4/0x1250 [kernel]
 0xffffffff8126dc41 : do_filp_open+0x91/0x100 [kernel]
 0xffffffff8125ad86 : do_sys_open+0x126/0x210 [kernel]
 0xffffffff81003864 : do_syscall_64+0x74/0x1a0 [kernel]
 0xffffffff81800081 : entry_SYSCALL_64_after_hwframe+0x3d/0xa2 [kernel]

I have patched it on online servers, It can improved the performance.

