Return-Path: <linux-ext4+bounces-2312-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152358BCD4B
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384E21C22613
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010F143884;
	Mon,  6 May 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8njteUy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JvLmPWp5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8njteUy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JvLmPWp5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57712142E8F;
	Mon,  6 May 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996944; cv=none; b=TXZ2jsPgkCUclO+GLx9Tz/YregYjjgOhKo8mepnuzYAp5mbERcHVtV0oD0Gf4M/zRGsdiJxGXVbUPoYPK3INcCM7ssIVpdL5xUgGKU81/sWrRsZsaOkaAlVWcAmR0c1vj8geElEezLrw3K/FfiF/Ysn+k1ZnGVSYWvsFFo0jXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996944; c=relaxed/simple;
	bh=SIoEa4aRnSFEuOwOjN7KY5Vugmu6+AFZFlmItQxyjSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Snw+A32Yo6VIq68Q3jKzP6eX99OB/Ohn71aNOuAhr5jN32UDhEmsZkQ/oKcUR975XkGyQO9pGS5he/XPEPPiH/7TlU388oj3MIBTHJMAFMYrfKwhjdqDWWbSK+3O4fJ3tWdeldeEalJ5FFrGO20B4Ej/p37c0N08QR/afmMeUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8njteUy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JvLmPWp5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8njteUy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JvLmPWp5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99DA93828A;
	Mon,  6 May 2024 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714996941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsgxXCio+OwLPEzdmTJFkDDGrsy5BNCKTyYGrGUUX3U=;
	b=d8njteUyuE+L6wdGwwkGkcRe3rvUUxIdO7Jxsv00Oo8QbO1PLKfc3Tid/2H7WnsQXTmO80
	gkPx3hzf8o7MhlhUnPEdsgVMz2Xei3Hz3zYwBcoS6iX1ILvMXrunmlS6Fhwi+zIQ0D0pW2
	TuIktwlp+w48f+8QDWOI1LXDPKTPet0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714996941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsgxXCio+OwLPEzdmTJFkDDGrsy5BNCKTyYGrGUUX3U=;
	b=JvLmPWp5hIJWuyrL/zT/apcECxdfCse63+CuuLXVOAb7SPN2bTTfbjKEwYO7Qi82nJ08bF
	rfSYDn0+9gu6tADA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714996941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsgxXCio+OwLPEzdmTJFkDDGrsy5BNCKTyYGrGUUX3U=;
	b=d8njteUyuE+L6wdGwwkGkcRe3rvUUxIdO7Jxsv00Oo8QbO1PLKfc3Tid/2H7WnsQXTmO80
	gkPx3hzf8o7MhlhUnPEdsgVMz2Xei3Hz3zYwBcoS6iX1ILvMXrunmlS6Fhwi+zIQ0D0pW2
	TuIktwlp+w48f+8QDWOI1LXDPKTPet0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714996941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsgxXCio+OwLPEzdmTJFkDDGrsy5BNCKTyYGrGUUX3U=;
	b=JvLmPWp5hIJWuyrL/zT/apcECxdfCse63+CuuLXVOAb7SPN2bTTfbjKEwYO7Qi82nJ08bF
	rfSYDn0+9gu6tADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48DB913A25;
	Mon,  6 May 2024 12:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id idzIDs3GOGakOwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 May 2024 12:02:21 +0000
Message-ID: <ea1129b5-4b27-434c-bc1b-1a06b5f867b9@suse.de>
Date: Mon, 6 May 2024 14:02:20 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Massive slowdown in kernels as of 6.x
To: Holger Kiehl <Holger.Kiehl@dwd.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
References: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwd.de:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/6/24 13:31, Holger Kiehl wrote:
> Hello,
> 
> on a 4 socket file server distributing ~90 million files with
> ~130TiB of data daily, I see a massive slowdown of IO operation
> after some time (sometimes in less then a day). This slowdown
> only started as of Kernel 6.x and does not happen with 5.15.x.
> Have so far tried, 6.0.9, 6.1.27 and 6.6.30 kernel and they all
> have this same slowdown effect after some time. If the load is
> taken away from the server and it is nearly idle, it still has
> this slowdown effect and only recovers after some hours by itself.
> During this slowdown and idle time I had a look at an rsync
> process with strace that was uploading some small files to the
> server and could see the slowdown here was in the rename() system
> call, all other system calls (read(), write(), newfstatat(),
> openat(), fchmod(), etc) where not effected:
> 
>     rename(".27095571.iXVMMT", "27095571")  = 0 <18.305817>
>     rename(".272629ef.22gv2x", "272629ef")  = 0 <18.325222>
>     rename(".275fbacf.UBj6J5", "275fbacf")  = 0 <18.317571>
>     rename(".277ab7da.K5y144", "277ab7da")  = 0 <18.312568>
>     rename(".27873039.ZQ4Lum", "27873039")  = 0 <18.310120>
>     rename(".27ebf01f.t1FKeU", "27ebf01f")  = 0 <18.376816>
>     rename(".27f97e6a.kJqqfL", "27f97e6a")  = 0 <18.290618>
>     rename(".28078cd9.rV7JdN", "28078cd9")  = 0 <18.315415>
>     rename(".28105bb4.gljiDk", "28105bb4")  = 0 <18.325392>
>     rename(".282209b1.Cy3Wt2", "282209b1")  = 0 <30.188303>
>     rename(".28888272.aUCxRj", "28888272")  = 0 <18.263236>
>     rename(".288d8408.XjfGbH", "288d8408")  = 0 <18.312444>
>     rename(".2897f455.hm3FG6", "2897f455")  = 0 <18.281729>
>     rename(".28d7d7e8.pzMMF6", "28d7d7e8")  = 0 <18.281402>
>     rename(".28d9a820.KQuaM0", "28d9a820")  = 0 <32.620562>
>     rename(".294ae845.8Y6vYR", "294ae845")  = 0 <18.289532>
>     rename(".294fee3f.eccu2p", "294fee3f")  = 0 <18.260564>
>     rename(".29581b50.zPTjTh", "29581b50")  = 0 <18.314536>
>     rename(".2975d45f.l5FUYX", "2975d45f")  = 0 <18.293864>
>     rename(".29b3770a.tlNMvb", "29b3770a")  = 0 <0.000062>
>     rename(".29c5e6ee.EexCwZ", "29c5e6ee")  = 0 <18.268144>
>     rename(".29d23183.sLqxpd", "29d23183")  = 0 <18.344478>
>     rename(".29d4f65.oyjRWj", "29d4f65")    = 0 <18.553610>
>     rename(".29dcfab1.Y47Z1B", "29dcfab1")  = 0 <18.339336>
>     rename(".29f26c7c.KNZXEe", "29f26c7c")  = 0 <18.372242>
>     rename(".2a09907b.SXIgev", "2a09907b")  = 0 <18.317119>
>     rename(".2a0c499c.8DiCsM", "2a0c499c")  = 0 <18.380393>
>     rename(".2a64b7e8.FPnsB3", "2a64b7e8")  = 0 <18.372004>
>     rename(".2a6765c9.t7Z0hj", "2a6765c9")  = 0 <18.296044>
>     rename(".2a83d78f.UJVoMu", "2a83d78f")  = 0 <18.380678>
>     rename(".2a94e724.AorYof", "2a94e724")  = 0 <18.360716>
>     rename(".2a9ea651.EWpBHM", "2a9ea651")  = 0 <18.327733>
>     rename(".2a9f1679.xDYq9Q", "2a9f1679")  = 0 <18.312850>
>     rename(".2ab0a134.2GWgmr", "2ab0a134")  = 0 <18.326181>
>     rename(".2aebf110.pGkILq", "2aebf110")  = 0 <0.000188>
>     rename(".2af10031.7Sl5g6", "2af10031")  = 0 <18.342683>
>     rename(".2b095066.MCauJX", "2b095066")  = 0 <18.375003>
>     rename(".2b217bfd.HauJjr", "2b217bfd")  = 0 <18.427703>
>     rename(".2b336a06.w5NN0p", "2b336a06")  = 0 <18.378774>
>     rename(".2b40b422.i2v0E6", "2b40b422")  = 0 <14.727797>
>     rename(".2b568d13.9zmRRX", "2b568d13")  = 0 <0.000056>
>     rename(".2b5ccc66.AFd86P", "2b5ccc66")  = 0 <0.000063>
>     rename(".2b7d0a43.qWyxge", "2b7d0a43")  = 0 <0.000046>
>     rename(".2b7f968a.QAqOCb", "2b7f968a")  = 0 <0.000041>
>     rename(".2ba6dddf.ynNTvi", "2ba6dddf")  = 0 <0.000039>
>     rename(".2bce23ab.tliDkg", "2bce23ab")  = 0 <0.000040>
>     rename(".2c19e144.CvHPV5", "2c19e144")  = 0 <0.000060>
>     rename(".2c7c0651.8x1kQy", "2c7c0651")  = 0 <0.000057>
>     rename(".2ca1a6b7.QwujH4", "2ca1a6b7")  = 0 <0.000396>
>     rename(".2cc71683.7n9EYA", "2cc71683")  = 0 <0.000045>
>     rename(".2cebde90.ZiGcTa", "2cebde90")  = 0 <0.000042>
>     rename(".2d057cb4.5PGOIP", "2d057cb4")  = 0 <0.000042>
>     rename(".2d29b4a7.A8hfwg", "2d29b4a7")  = 0 <0.000043>
> 
> So during the slow phase it took mostly ~18 seconds and as the phase
> ends, the renames are very fast again.
> 
> Tried to change the priority of the process with renice and
> also enabled some different IO schedulers for the block device,
> but this had no effect.
> 
> Could not find anything in the logs or dmesg when this happens.
> 
> Any idea what could be the cause of this slowdown?
> 
> What else can I do to better locate in which part of the kernel
> the IO is stuck?
> 
> The system has 1.5TiB memory and the filesystem is ext4 on a MD
> raid10 with 10 nvme drives (Intel P4610):
> 
>     cat /proc/mdstat
>     Personalities : [raid10]
>     md0 : active raid10 nvme1n1[2] nvme4n1[4] nvme5n1[5] nvme3n1[3] nvme9n1[9] nvme8n1[8] nvme7n1[7] nvme6n1[6] nvme2n1[1] nvme0n1[0]
>           7813406720 blocks super 1.2 512K chunks 2 near-copies [10/10] [UUUUUUUUUU]
>           bitmap: 28/59 pages [112KB], 65536KB chunk
> 
> Mounted as follows:
> 
>     /dev/md0 on /u2 type ext4 (rw,nodev,noatime,commit=600,stripe=640)
> 
> The following cron entry is used to trim the device:
> 
>     25 */2 * * * root /usr/sbin/fstrim -v /u2 >> /tmp/u2.trim 2>&1
> 
> A check of the raid was also performed with no issues:
> 
>     [Sun May  5 13:52:01 2024] md: data-check of RAID array md0
>     [Sun May  5 14:54:25 2024] md: md0: data-check done.
>     cat /sys/block/md0/md/mismatch_cnt
>     0
> 
> CPU's are four Intel Xeon Platinum 8268 and server is a Dell Poweredge R940.
> 
> Additional information of the kernel config and other information I have
> uploaded to https://download.dwd.de/pub/afd/test/kernel_problem
> 
There had been some discard regressions in the MD code, which I thought 
Coly had fixed in the meantime.

To rule that out please disable the 'cron' job and see if the slowdown 
persists.

Cheers,

Hannes


