Return-Path: <linux-ext4+bounces-3600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7DC9459E4
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7313D280D24
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18E1C2320;
	Fri,  2 Aug 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="gj3npwMm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D41BF322;
	Fri,  2 Aug 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587339; cv=none; b=OW0QTdFWt+uAhX+qLFGK1P6Ioz//E8Cjo7Y8sVlb/3jYvrGBNJdRybraiLKNOSNo38dqrU/HVQk+6MSLEvUxL4R9/1DzunmwuOqDqLTbIGJ1Qnrz5IxSas5ng1Wg3xd5bNifcYDpftxl10z/Dx7BwMInun6vxarhfHTVTb5+XwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587339; c=relaxed/simple;
	bh=/z+zFYKBSUFKM7U8ttpJ7t92yC/LDxSX4M4fRJ/rBEA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=EeFvLsml1dxpQG3+2dBEdFfiGq0rFVKPvT+4Yu83cBcSnF4RbYdkAlh5jictZlfXuvi88J0nO+N15qbgmV18sefWajIcxG7N7Q8JKqY1vGy9FvrdmApNHhUzVsc8yXoXdTafNNO5ZOgVsVLs/Cv1lM8HhERRmrcruS4UrJnL+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=gj3npwMm; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1722587328; x=1723192128; i=max.schulze@online.de;
	bh=Nya/fQEJI0Xly9FcerXMgPWVeNJKptVkuAh4IC6pQ7E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gj3npwMm8zWGPNe6A1gRBHCUW0WmHYHvsBR/Lvhp987LqqNKegOWlOUTDe6HGEiW
	 UpN5lanAQ522CQgx5OA9jK7gU3R03M8cii8P4nhWJ56sXO+yRKcFmh1ZULkO+7j5m
	 ohV0JF2wdq7ULtSyG44qTKX7iC3hITXSww6jbtDV24m1UF1VIJqFafBHtiUSAU8b5
	 Moav4Q0JhRzILDbi3LdtE1COTlMZwYZ0oZP+E+tXKHZg6GjJHz4axCjzheu/QoEvC
	 U1ygZ+PZvViNe7B7Om6d5rfX0t8pY5wi/+A1HrdLQTivtEbRhv6tf0C3d6pwRjF4C
	 x1kqQedsZp/X/pumUw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.151.46] ([217.224.125.217]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRT6b-1sv1xa3iiL-00PO41; Fri, 02 Aug 2024 10:28:47 +0200
Message-ID: <87a26aff-78b4-4e87-9c83-8239d238b381@online.de>
Date: Fri, 2 Aug 2024 10:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrace@vger.kernel.org, axboe@kernel.dk
From: Max Schulze <max.schulze@online.de>
Subject: Understanding blktrace; measuring extra writes on ext4 with
 open(...,O_DSNYC | O_TRUNC)
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LObGisLXhUsEyW62EtTK7Q4pz7v3ZTUbhYNvp9OLSr+SS5/odpI
 7F6NrwQYYKOfzcr03dF31AmbohSX5uamB7rMKP0bQbpbgBZkyW8kO0FZR1+q+UUuHUMe0w3
 atrtLRvoUtlSnmWOcw6rLl25BrHiK6EyK4Cv4tNfsY8F95oGqL8+BI2TjUXpFGAwjkvgRnz
 E0aaM9xa0q4yjz1s3MlkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gykHomEcugc=;pKA17fTjPZts73BtLSJYOW34Msw
 xbRIaluB9UCHIxo+ix6Zc4YzmOOUM/JFUN/iZN9eD0L24CAXABSV8zE2NGWwllrU/o60IAQzG
 kTNh8GmcRS9RkW3HK1N4A0dUUzUawqKxIvmOLbDi3ZJjPfWnPDeRdaQqLMEvXfk6JVVKZXv1X
 kmI6nJAer7JmGEmAjQfUk6iEjVVuOXW2eN/oXShP4OAqNPzNYspscQ1MPcQm9iUHZcug476sx
 5O8sYvwFK6CCMexTfDspPV4XYE0xnRXXsVmqWCHY3YbGr0M+c4F92Y/mCyfVe7a9l0JIIejQk
 /4OFqEYTXX8nDgisKQKay6pCzDs61Kx108Dt338hTdZT8IwRjPz9EgivZBNfj4JtUxZ8WncU1
 jBqwG5j59qta+BE4eBYo2lpHwx07Ofon+oT6rocRLmXvHqhc62gZRosas0+A9ef3p8K9RaNZd
 Mm98ebb6MPGM2GPz2FVCLHWSbASJVUJv/yz8yRN+f5viiJp6nYAV5PGA64lCffQDdLi198X3c
 QzllXpt9VTt0M1V5NuXyVBmS+en+0Xag7nomyY1L5G6gnsjHuXVZ6GjSDR8PjReDeCX/ACMcE
 AHEqlswOmBnRuBR24VMIpiVYr/4P33v4CTZOvKTN1asyRJSUMO8gTUwM5xdHBp4LbDh3zgqSy
 WTRC3xCc+D2Gq2gPLRy8eJTfVsrTNLW5i+ohuuqzYf2459bUKZdts6x0nooSbPMD6me5PiBAS
 4alBzgytvF/fmLDxlgLi1cSehWBRXzGqQ==

Hello,

so I have an embedded application with limited flash write cycles. I am wr=
iting 2 blocks to disk 5 times a second (ext4, block size 1024).
The data written is binary and fixed size and to date I open the files wit=
h (O_CREAT | O_WRONLY | O_DSYNC | O_TRUNC).

I set out to measure whether this O_TRUNC leads to an extra write (because=
 I might be able to do without - data is fixed size) and understand the li=
nux tooling around for inspection.

I wrote a test script, that creates a 2MB ext4 file system on a separate b=
lock device, so I can trace with blktrace -d /dev/sdc

If somebody please could have a look if the interpretation of the traces i=
s correct and what the missing identifiers are.


Below is the output from blkparse for the moments where I write with open =
(DSYNC | TRUNC)

>
>   8,32   2      152     8.831293895 22900  C RAM 2060 + 2 [0]           =
  <-- previous _C_omplete
>   8,32  10        2     9.245982628 14449  D   N 0 [kworker/u40:2]      =
  <-- D =3Dissued
>   8,32   2      153     9.246369033 22900  C   N [0]                    =
  <-- C_omplete
>   8,32   0      200     9.268019255 15706  A  RM 2062 + 2 <- (8,33) 14  =
  <-- A =3D remap
>   8,32   0      201     9.268020922 15706  Q  RM 2062 + 2 [writerdt]    =
  <-- Queued
>   8,32   0      202     9.268034745 15706  G  RM 2062 + 2 [writerdt]    =
  <-- Get =3D allocate Req.
>   8,32   0      203     9.268051167 15706  I  RM 2062 + 2 [writerdt]    =
  <-- I_nserted in Queue
>   8,32   0      204     9.268107127   161  D  RM 2062 + 2 [kworker/0:1H]=
  <-- D issued "R"ead
>   8,32   2      154     9.268704050 22900  C  RM 2062 + 2 [0]
>   8,32   0      205     9.268881750 15706  A  WS 2160 + 2 <- (8,33) 112
>   8,32   0      206     9.268882510 15706  Q  WS 2160 + 2 [writerdt]
>   8,32   0      207     9.268890935 15706  G  WS 2160 + 2 [writerdt]
>   8,32   0      208     9.268891685 15706  P   N [writerdt]
>   8,32   0      209     9.268892510 15706  U   N [writerdt] 1
>   8,32   0      210     9.268895672 15706  I  WS 2160 + 2 [writerdt]
>   8,32   0      211     9.268913234 15706  D  WS 2160 + 2 [writerdt]    =
  <-- D issued "W"rite "S"ynchronous
>   8,32   2      155     9.271009859 22900  C  WS 2160 + 2 [0]
>   8,32   0      212     9.271041534 15706  A WSM 2126 + 2 <- (8,33) 78
>   8,32   0      213     9.271041910 15706  Q WSM 2126 + 2 [writerdt]
>   8,32   0      214     9.271051615 15706  G WSM 2126 + 2 [writerdt]
>   8,32   0      215     9.271053774 15706  I WSM 2126 + 2 [writerdt]
>   8,32   0      216     9.271075678   161  D WSM 2126 + 2 [kworker/0:1H]=
  <-- D issued "W"rite "S"ynchronous
>   8,32   2      156     9.273122709 22900  C WSM 2126 + 2 [0]
>   8,32   4       67    10.277429577 13420  A  WM 2050 + 2 <- (8,33) 2


-> What are M and N in the "rwbs" field? I could not find this in the manp=
age.

-> So it looks like this does 2 write operations. This is consistent with =
ext4 changing the extent for the file (for truncing to 0-length first).


Now I do this again without truncation and get

>
>   8,32   8       12    12.446019890 15060  D   N 0 [kworker/u40:10]
>   8,32   0      223    12.446327254 22900  C   N [0]
>   8,32  12       18    14.462068679 15060  D   N 0 [kworker/u40:10]
>   8,32   0      224    14.462286092 22900  C   N [0]
>   8,32   1        4    14.471326135 15725  A  RM 2062 + 2 <- (8,33) 14
>   8,32   1        5    14.471327925 15725  Q  RM 2062 + 2 [writerd]
>   8,32   1        6    14.471344608 15725  G  RM 2062 + 2 [writerd]
>   8,32   1        7    14.471361723 15725  I  RM 2062 + 2 [writerd]
>   8,32   1        8    14.471421391   358  D  RM 2062 + 2 [kworker/1:1H]=
  <-- D issued "R"ead
>   8,32   0      225    14.472161215 22900  C  RM 2062 + 2 [0]
>   8,32   1        9    14.472240211 15725  A   R 2158 + 2 <- (8,33) 110
>   8,32   1       10    14.472240898 15725  Q   R 2158 + 2 [writerd]
>   8,32   1       11    14.472247182 15725  G   R 2158 + 2 [writerd]
>   8,32   1       12    14.472250123 15725  I   R 2158 + 2 [writerd]
>   8,32   1       13    14.472273237   358  D   R 2158 + 2 [kworker/1:1H]=
  <-- D issued "R"ead
>   8,32   0      226    14.472751621 22900  C   R 2158 + 2 [0]
>   8,32   1       14    14.472792434 15725  A  WS 2158 + 2 <- (8,33) 110
>   8,32   1       15    14.472792995 15725  Q  WS 2158 + 2 [writerd]
>   8,32   1       16    14.472798733 15725  G  WS 2158 + 2 [writerd]
>   8,32   1       17    14.472799196 15725  P   N [writerd]
>   8,32   1       18    14.472800161 15725  U   N [writerd] 1
>   8,32   1       19    14.472802573 15725  I  WS 2158 + 2 [writerd]
>   8,32   1       20    14.472812600 15725  D  WS 2158 + 2 [writerd]     =
  <-- D issued "W"rite "S"ynchronous
>   8,32   0      227    14.474721702 22900  C  WS 2158 + 2 [0]
>   8,32   9       84    14.621987608 15718  A RAM 2060 + 2 <- (8,33) 12
>   8,32   9       85    14.621989072 15718  Q RAM 2060 + 2 [ext4lazyinit]
>   8,32   9       86    14.622005410 15718  G RAM 2060 + 2 [ext4lazyinit]
>   8,32   9       87    14.622006544 15718  P   N [ext4lazyinit]
>   8,32   9       88    14.622007637 15718  U   N [ext4lazyinit] 1
>   8,32   9       89    14.622023937 15718  I RAM 2060 + 2 [ext4lazyinit]
>   8,32   9       90    14.622060975 15718  D RAM 2060 + 2 [ext4lazyinit]
>   8,32   0      228    14.622902229 22900  C RAM 2060 + 2 [0]
>   8,32   5       29    15.479070846 14449  A  WM 2050 + 2 <- (8,33) 2

-> and only get one issued Write (rewriting one block), but 2 reads.

This seems very consistend with the statistics, however, why is only 1/2 w=
rites "dispatched"? Do reads never get dispatched or is it just not accoun=
ted in the process because of kernel worker?

> blkparse -s reports for the writing processes
>
> writerdt (15706)
>  Reads Queued:           1,        1KiB	 Writes Queued:           2,    =
    2KiB
>  Read Dispatches:        0,        0KiB	 Write Dispatches:        1,    =
    1KiB
>  Reads Requeued:         0		         Writes Requeued:         0
>  Reads Completed:        0,        0KiB	 Writes Completed:        0,    =
    0KiB
>  Read Merges:            0,        0KiB	 Write Merges:            0,    =
    0KiB
>  IO unplugs:             1        	         Timer unplugs:           0
>
> writerd (15725)
>  Reads Queued:           2,        2KiB	 Writes Queued:           1,    =
    1KiB
>  Read Dispatches:        0,        0KiB	 Write Dispatches:        1,    =
    1KiB
>  Reads Requeued:         0		         Writes Requeued:         0
>  Reads Completed:        0,        0KiB	 Writes Completed:        0,    =
    0KiB
>  Read Merges:            0,        0KiB	 Write Merges:            0,    =
    0KiB
>  IO unplugs:             1        	         Timer unplugs:           0
>


My conclusion for now:
 If your data is fixed-length, and you are guaranteed to rewrite the file =
contents in full, do not do O_TRUNC, because it saves one write to the blo=
ck device (on ext4) - but on the cost of one extra read.


Thanks,

Max



Addendum: debugfs inspections show that writing with O_TRUNC changes the e=
xtent on the file, but withouth O_TRUNC it doesn't

> -- before test
>
> debugfs:  stat t_dsync_trunc.txt
> Inode: 12   Generation: 2004264324    Version: 0x00000001
> EXTENTS: (0):54
>
> debugfs:  stat t_dsync_notrunc.txt
> Inode: 13   Generation: 1582093351    Version: 0x00000001
> EXTENTS: (0):55
>
>
> -- after writing to t_dsync_trunc.txt
>
> debugfs:  stat t_dsync_trunc.txt
> Inode: 12   Generation: 2004264324    Version: 0x00000002
> EXTENTS: (0):56
>
> debugfs:  stat t_dsync_notrunc.txt
> Inode: 13   Generation: 1582093351    Version: 0x00000001
> EXTENTS: (0):55
>
>
> -- after writing to t_dsync_notrunc.txt
>
> debugfs:  stat t_dsync_trunc.txt
> Inode: 12   Generation: 2004264324    Version: 0x00000002
> EXTENTS: (0):56
>
> debugfs:  stat t_dsync_notrunc.txt
> Inode: 13   Generation: 1582093351    Version: 0x00000002
> EXTENTS: (0):55

Addendum: trace-cmd for writerdt

>     ext4lazyinit-15688 [005] 59288.685923: ext4_prefetch_bitmaps: dev 8,=
33 group 0 next 0 ios 1
>         writerdt-15706 [000] 59289.122525: ext4_es_lookup_extent_enter: =
dev 8,33 ino 2 lblk 0
>         writerdt-15706 [000] 59289.122527: ext4_es_lookup_extent_exit: d=
ev 8,33 ino 2 found 0 [0/0) 0
>         writerdt-15706 [000] 59289.122529: ext4_ext_map_blocks_enter: de=
v 8,33 ino 2 lblk 0 len 1 flags
>         writerdt-15706 [000] 59289.122531: ext4_es_cache_extent: dev 8,3=
3 ino 2 es [0/1) mapped 7 status W
>         writerdt-15706 [000] 59289.122533: ext4_ext_show_extent: dev 8,3=
3 ino 2 lblk 0 pblk 7 len 1
>         writerdt-15706 [000] 59289.122534: ext4_ext_map_blocks_exit: dev=
 8,33 ino 2 flags  lblk 0 pblk 7 len 1 mflags M ret 1
>         writerdt-15706 [000] 59289.122536: ext4_es_insert_extent: dev 8,=
33 ino 2 es [0/1) mapped 7 status W
>         writerdt-15706 [000] 59289.123269: ext4_journal_start:   dev 8,3=
3 blocks 1, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b4f38a5S
>         writerdt-15706 [000] 59289.123285: ext4_journal_start:   dev 8,3=
3 blocks 3, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50e40aS
>         writerdt-15706 [000] 59289.123287: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50e814S
>         writerdt-15706 [000] 59289.123292: ext4_truncate_enter:  dev 8,3=
3 ino 12 blocks 2
>         writerdt-15706 [000] 59289.123294: ext4_journal_start:   dev 8,3=
3 blocks 6, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50beafS
>         writerdt-15706 [000] 59289.123295: ext4_discard_preallocations: =
dev 8,33 ino 12 len: 0 needed 0
>         writerdt-15706 [000] 59289.123296: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b4ee524S
>         writerdt-15706 [000] 59289.123297: ext4_es_remove_extent: dev 8,=
33 ino 12 es [0/4294967295)
>         writerdt-15706 [000] 59289.123298: ext4_journal_start:   dev 8,3=
3 blocks 1, rsv_blocks 0, revoke_creds 0, caller 0xffffffff8b4ecc8fS
>         writerdt-15706 [000] 59289.123299: ext4_ext_remove_space: dev 8,=
33 ino 12 since 0 end 4294967294 depth 0
>         writerdt-15706 [000] 59289.123300: ext4_ext_rm_leaf:     dev 8,3=
3 ino 12 start_lblk 0 last_extent [0(54), 1]partial [pclu 0 lblk 0 state 0=
]
>         writerdt-15706 [000] 59289.123302: ext4_remove_blocks:   dev 8,3=
3 ino 12 extent [0(54), 1]from 0 to 0 partial [pclu 0 lblk 0 state 0]
>         writerdt-15706 [000] 59289.123303: ext4_free_blocks:     dev 8,3=
3 ino 12 mode 0>o< block 33188 count 54 flags 1
>         writerdt-15706 [000] 59289.123306: ext4_mballoc_free:    dev 8,3=
3 inode 12 extent 0/53/1
>         writerdt-15706 [000] 59289.123313: ext4_journal_start:   dev 8,3=
3 blocks 2, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50e969S
>         writerdt-15706 [000] 59289.123313: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50e98bS
>         writerdt-15706 [000] 59289.123317: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b4e6ca4S
>         writerdt-15706 [000] 59289.123318: ext4_ext_remove_space_done: d=
ev 8,33 ino 12 since 0 end 4294967294 depth 0 partial [pclu 0 lblk 0 state=
 0] remaining_entries 0
>         writerdt-15706 [000] 59289.123319: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b4e6ca4S
>         writerdt-15706 [000] 59289.123320: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50bf86S
>         writerdt-15706 [000] 59289.123321: ext4_truncate_exit:   dev 8,3=
3 ino 12 blocks 0
>         writerdt-15706 [000] 59289.123322: ext4_journal_start:   dev 8,3=
3 blocks 2, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50e969S
>         writerdt-15706 [000] 59289.123322: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50e98bS
>         writerdt-15706 [000] 59289.123334: ext4_write_begin:     dev 8,3=
3 ino 12 pos 0 len 128
>         writerdt-15706 [000] 59289.123341: ext4_journal_start:   dev 8,3=
3 blocks 7, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50c313S
>         writerdt-15706 [000] 59289.123342: ext4_es_lookup_extent_enter: =
dev 8,33 ino 12 lblk 0
>         writerdt-15706 [000] 59289.123343: ext4_es_lookup_extent_exit: d=
ev 8,33 ino 12 found 0 [0/0) 0
>         writerdt-15706 [000] 59289.123343: ext4_ext_map_blocks_enter: de=
v 8,33 ino 12 lblk 0 len 1 flags
>         writerdt-15706 [000] 59289.123345: ext4_es_find_extent_range_ent=
er: dev 8,33 ino 12 lblk 0
>         writerdt-15706 [000] 59289.123346: ext4_es_find_extent_range_exi=
t: dev 8,33 ino 12 es [0/0) mapped 0 status
>         writerdt-15706 [000] 59289.123346: ext4_es_insert_extent: dev 8,=
33 ino 12 es [0/4294967295) mapped 0 status H
>         writerdt-15706 [000] 59289.123347: ext4_ext_map_blocks_exit: dev=
 8,33 ino 12 flags  lblk 0 pblk 0 len 1 mflags  ret 0
>         writerdt-15706 [000] 59289.123348: ext4_ext_map_blocks_enter: de=
v 8,33 ino 12 lblk 0 len 1 flags CREATE
>         writerdt-15706 [000] 59289.123349: ext4_request_blocks:  dev 8,3=
3 ino 12 flags HINT_DATA len 1 lblk 0 goal 8193 lleft 0 lright 0 pleft 0 p=
right 0
>         writerdt-15706 [000] 59289.123353: ext4_journal_start:   dev 8,3=
3 blocks 2, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50e969S
>         writerdt-15706 [000] 59289.123353: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50e98bS
>         writerdt-15706 [000] 59289.123372: ext4_mb_new_group_pa: dev 8,3=
3 ino 12 pstart 56 len 512 lstart 56
>         writerdt-15706 [000] 59289.123376: ext4_mballoc_alloc:   dev 8,3=
3 inode 12 orig 0/0/1@0 goal 0/0/512@0 result 0/55/512@0 blks 5 grps 1 cr =
2 flags HINT_DATA|HINT_GRP_ALLOC tail 55 broken 256
>         writerdt-15706 [000] 59289.123377: ext4_allocate_blocks: dev 8,3=
3 ino 12 flags HINT_DATA len 1 block 56 lblk 0 goal 8193 lleft 0 lright 0 =
pleft 0 pright 0
>         writerdt-15706 [000] 59289.123379: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b4e6ca4S
>         writerdt-15706 [000] 59289.123380: ext4_ext_map_blocks_exit: dev=
 8,33 ino 12 flags CREATE lblk 0 pblk 56 len 1 mflags NM ret 1
>         writerdt-15706 [000] 59289.123381: ext4_es_insert_extent: dev 8,=
33 ino 12 es [0/1) mapped 56 status W
>         writerdt-15706 [000] 59289.123385: ext4_write_end:       dev 8,3=
3 ino 12 pos 0 len 128 copied 128
>         writerdt-15706 [000] 59289.123387: ext4_mark_inode_dirty: dev 8,=
33 ino 12 caller 0xffffffff8b50d462S
>         writerdt-15706 [000] 59289.123391: ext4_sync_file_enter: dev 8,3=
3 ino 12 parent 2 datasync 1
>         writerdt-15706 [000] 59289.123393: ext4_writepages:      dev 8,3=
3 ino 12 nr_to_write 9223372036854775807 pages_skipped 0 range_start 0 ran=
ge_end 127 sync_mode 1 for_kupdate 0 range_cyclic 0 writeback_index 0
>         writerdt-15706 [000] 59289.123402: ext4_journal_start:   dev 8,3=
3 blocks 6, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50a8baS
>         writerdt-15706 [000] 59289.123402: ext4_da_write_pages:  dev 8,3=
3 ino 12 first_page 0 nr_to_write 9223372036854775807 sync_mode 1
>         writerdt-15706 [000] 59289.123444: ext4_writepages_result: dev 8=
,33 ino 12 ret 0 pages_written 1 pages_skipped 0 sync_mode 1 writeback_ind=
ex 0
>         writerdt-15706 [000] 59289.127668: ext4_sync_file_exit:  dev 8,3=
3 ino 12 ret 0
>         writerdt-15706 [000] 59289.127675: ext4_alloc_da_blocks: dev 8,3=
3 ino 12 reserved_data_blocks 0
>         writerdt-15706 [000] 59289.127683: ext4_discard_preallocations: =
dev 8,33 ino 12 len: 0 needed 0
>             sync-15708 [005] 59290.134496: ext4_sync_fs:         dev 7,5=
 wait 0
>             sync-15708 [005] 59290.134503: ext4_sync_fs:         dev 8,3=
3 wait 0


Addendum: trac-cmd for writerd

>             sync-15719 [005] 59290.312417: ext4_sync_fs:         dev 8,3=
3 wait 1
>          writerd-15725 [001] 59294.325659: ext4_es_lookup_extent_enter: =
dev 8,33 ino 2 lblk 0
>          writerd-15725 [001] 59294.325661: ext4_es_lookup_extent_exit: d=
ev 8,33 ino 2 found 0 [0/0) 0
>          writerd-15725 [001] 59294.325663: ext4_ext_map_blocks_enter: de=
v 8,33 ino 2 lblk 0 len 1 flags
>          writerd-15725 [001] 59294.325665: ext4_es_cache_extent: dev 8,3=
3 ino 2 es [0/1) mapped 7 status W
>          writerd-15725 [001] 59294.325677: ext4_ext_show_extent: dev 8,3=
3 ino 2 lblk 0 pblk 7 len 1
>          writerd-15725 [001] 59294.325678: ext4_ext_map_blocks_exit: dev=
 8,33 ino 2 flags  lblk 0 pblk 7 len 1 mflags M ret 1
>          writerd-15725 [001] 59294.325679: ext4_es_insert_extent: dev 8,=
33 ino 2 es [0/1) mapped 7 status W
>          writerd-15725 [001] 59294.326569: ext4_journal_start:   dev 8,3=
3 blocks 1, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b4f38a5S
>          writerd-15725 [001] 59294.326589: ext4_journal_start:   dev 8,3=
3 blocks 2, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50e969S
>          writerd-15725 [001] 59294.326590: ext4_mark_inode_dirty: dev 8,=
33 ino 13 caller 0xffffffff8b50e98bS
>          writerd-15725 [001] 59294.326597: ext4_write_begin:     dev 8,3=
3 ino 13 pos 0 len 128
>          writerd-15725 [001] 59294.326603: ext4_journal_start:   dev 8,3=
3 blocks 7, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50c313S
>          writerd-15725 [001] 59294.326605: ext4_es_lookup_extent_enter: =
dev 8,33 ino 13 lblk 0
>          writerd-15725 [001] 59294.326605: ext4_es_lookup_extent_exit: d=
ev 8,33 ino 13 found 0 [0/0) 0
>          writerd-15725 [001] 59294.326606: ext4_ext_map_blocks_enter: de=
v 8,33 ino 13 lblk 0 len 1 flags
>          writerd-15725 [001] 59294.326607: ext4_es_cache_extent: dev 8,3=
3 ino 13 es [0/1) mapped 55 status W
>          writerd-15725 [001] 59294.326608: ext4_ext_show_extent: dev 8,3=
3 ino 13 lblk 0 pblk 55 len 1
>          writerd-15725 [001] 59294.326609: ext4_ext_map_blocks_exit: dev=
 8,33 ino 13 flags  lblk 0 pblk 55 len 1 mflags M ret 1
>          writerd-15725 [001] 59294.326609: ext4_es_insert_extent: dev 8,=
33 ino 13 es [0/1) mapped 55 status W
>          writerd-15725 [001] 59294.327134: ext4_write_end:       dev 8,3=
3 ino 13 pos 0 len 128 copied 128
>          writerd-15725 [001] 59294.327137: ext4_mark_inode_dirty: dev 8,=
33 ino 13 caller 0xffffffff8b50d462S
>          writerd-15725 [001] 59294.327141: ext4_sync_file_enter: dev 8,3=
3 ino 13 parent 2 datasync 1
>          writerd-15725 [001] 59294.327144: ext4_writepages:      dev 8,3=
3 ino 13 nr_to_write 9223372036854775807 pages_skipped 0 range_start 0 ran=
ge_end 127 sync_mode 1 for_kupdate 0 range_cyclic 0 writeback_index 0
>          writerd-15725 [001] 59294.327156: ext4_journal_start:   dev 8,3=
3 blocks 6, rsv_blocks 0, revoke_creds 8, caller 0xffffffff8b50a8baS
>          writerd-15725 [001] 59294.327156: ext4_da_write_pages:  dev 8,3=
3 ino 13 first_page 0 nr_to_write 9223372036854775807 sync_mode 1
>          writerd-15725 [001] 59294.327188: ext4_writepages_result: dev 8=
,33 ino 13 ret 0 pages_written 1 pages_skipped 0 sync_mode 1 writeback_ind=
ex 0
>          writerd-15725 [001] 59294.329112: ext4_sync_file_exit:  dev 8,3=
3 ino 13 ret 0
>          writerd-15725 [001] 59294.329118: ext4_discard_preallocations: =
dev 8,33 ino 13 len: 0 needed 0
>     ext4lazyinit-15718 [009] 59294.476346: ext4_read_block_bitmap_load: =
dev 8,33 group 0 prefetch 1
>     ext4lazyinit-15718 [009] 59294.477287: ext4_mb_bitmap_load:  dev 8,3=
3 group 0
>     ext4lazyinit-15718 [009] 59294.477288: ext4_mb_buddy_bitmap_load: de=
v 8,33 group 0
>     ext4lazyinit-15718 [009] 59294.477293: ext4_prefetch_bitmaps: dev 8,=
33 group 0 next 0 ios >    kworker/u40:2-14449 [005] 59295.333445: ext4_wr=
itepages:      dev 8,33 ino 13 nr_to_write 1024 pages_skipped 0 range_star=
t 0 range_end 9223372036854775807 sync_mode 0 for_kupdate 0 range_cyclic 1=
 writeback_index 0
>    kworker/u40:2-14449 [005] 59295.333447: ext4_writepages_result: dev 8=
,33 ino 13 ret 0 pages_written 0 pages_skipped 0 sync_mode 0 writeback_ind=
ex 0
>             sync-15727 [007] 59295.357066: ext4_sync_fs:         dev 7,5=
 wait 0
>             sync-15727 [007] 59295.357072: ext4_sync_fs:         dev 8,3=
3 wait 0




Addendum: writer.c sourcecode
>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdbool.h>
>
> const char* argopt(int argc, const char *const *argv, char key){
>     for(int i=3D1; i<argc; i++){
>         const char *c =3D argv[i];
>         if(*c!=3D'-') continue;
>         while(*++c) if(*c=3D=3Dkey) return argv[(i+1)%argc];
>     }
>    return 0;
> }
>
>
> int main(int argc, char **argv){
>     bool trunc =3D false;
>     bool dsync =3D false;
>     if(argopt(argc, argv, 't')) { trunc=3D true; }
>     if(argopt(argc, argv, 'd')) { dsync =3D true;}
>
>     const char *o =3D argopt(argc, argv, 'o');
>
>     const char *c =3D argopt(argc, argv, 'c');
>
>     if (!c) {printf("-c is empty");return 1;}
>
>     int fd1;
>
>     int extra =3D 0;
>     if (trunc) extra |=3D O_TRUNC;
>     if (dsync) extra |=3D O_DSYNC;
>     fd1 =3D open(o, O_CREAT | O_WRONLY | extra, S_IRUSR | S_IWUSR);
>     write(fd1,c,strlen(c));
>
>     close(fd1);
>
>     return 0;
> }





testrunner script
> #!/bin/bash
>
> #c860942c211b9946217df2753a0354ab0d182c0d94b5fd1cf1b9b4d74493ab9d  shasu=
mgenerate
>
> cd /dev/shm
> ln -s writer writerdt
> ln -s writer writerd
> mkdir /dev/shm/blkmnt
> umount /dev/sdc1
>
>  # If enabled and the uninit_bg feature is enabled, the inode table will=
 not be fully initialized by mke2fs. This speeds up filesystem initializat=
ion noticeably, but it requires the kernel to finish initializing the file=
system in the background when the filesystem is first mounted. If the opti=
on value is omitted, it defaults to 1 to enable lazy inode table zeroing.
> mkfs.ext4 -F -E lazy_itable_init=3D0,lazy_journal_init=3D0 /dev/sdc1 1M
> sync /dev/shm/blkmnt/
> sleep 5
> mount /dev/sdc1 /dev/shm/blkmnt
>
> echo "emptyfile"  > /dev/shm/blkmnt/t_dsync_trunc.txt
> echo "emptyfile"  > /dev/shm/blkmnt/t_dsync_notrunc.txt
>
> umount /dev/sdc1
> dd if=3D/dev/sdc1 bs=3D4M count=3D2 of=3D/dev/shm/emptystart.bin
>
> mount /dev/sdc1 /dev/shm/blkmnt
> sync
>
> sleep 4
> date
> DUDU=3D$(date +%X)"_"$(cat /proc/uptime)"_"$(uname -r)"_abcdefghijklmnop=
qrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz123456789"
> time ./writerdt -d -t -o /dev/shm/blkmnt/t_dsync_trunc.txt -c "${DUDU:0:=
128}"
> sleep 1
> sync
>
>
> umount /dev/sdc1
> dd if=3D/dev/sdc1 bs=3D4M count=3D2 of=3D/dev/shm/after_dsync_trunc.bin
>
> mount /dev/sdc1 /dev/shm/blkmnt
> sync
>
> sleep 4
> date
> DUDU=3D$(date +%X)"_"$(cat /proc/uptime)"_"$(uname -r)"_abcdefghijklmnop=
qrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz123456789"
> time ./writerd -d  -o /dev/shm/blkmnt/t_dsync_notrunc.txt -c "${DUDU:0:1=
28}"
> sleep 1
> sync
>
> umount /dev/sdc1
> dd if=3D/dev/sdc1 bs=3D4M count=3D2 of=3D/dev/shm/after_dsync.bin
>
> export PAGER=3Dcat
>
> echo "emptystart"
> debugfs /dev/shm/emptystart.bin <<EOF
> stats
> stat t_dsync_trunc.txt
> stat t_dsync_notrunc.txt
> EOF
>
> echo "after dsync_trunc"
> debugfs /dev/shm/after_dsync_trunc.bin <<EOF
> stats
> stat t_dsync_trunc.txt
> stat t_dsync_notrunc.txt
> EOF
>
>
> echo "after_dsync"
> debugfs /dev/shm/after_dsync.bin <<EOF
> stats
> stat t_dsync_trunc.txt
> stat t_dsync_notrunc.txt
> EOF


