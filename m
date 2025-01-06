Return-Path: <linux-ext4+bounces-5912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F959A03058
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67E61882B4F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985221DFD9E;
	Mon,  6 Jan 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qhZOeIyR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F58198A29;
	Mon,  6 Jan 2025 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190997; cv=none; b=lDOYotjHhyL4Kq1ruqy0jaodL3R4ZJxtMpRtKGV598lwhWE6CkpYlRR2lVJYL2UT0PD+3n+srHkEaC+mDl2pkHoMfeE+CoChPik9p+sMet4fsxx+Fqucnpuag9NHjiDuU35EOHVi9fLGdgTkJnoXgh0rDwgruPrZA3qV6jm90xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190997; c=relaxed/simple;
	bh=FPUeTZ4CjE7g2WK6fUrOzOT2eEf2pOSWPYSggg52BII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+z3Y97ZXtxcgZqopOf2hZ0cdOsBhvdA2IB9A6NPWX3fvLMYQGHh6weVrAdJ2niuxeZHiXgW7+yRLDS7APwu/rubdZlgiewBerPhchF0eZ7ybbXytWt6E/w0tyUhsnTuxa5FgZD4vp6BFMGQW6hPjfxF/F7Z7AhzcebQEwq8fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qhZOeIyR; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id UsaKtY5qpPdSSUsaNtXY18; Mon, 06 Jan 2025 20:16:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736190984;
	bh=4vcRFJhpxUBnSVUT/ms+1EMRzx75bRoBl5aWpr6ps3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qhZOeIyRW1OVVVJYr7MML5OVhuNbr1AYm2zEmYckGfwLFeCE5AAjfHtP1HQeuCWWr
	 8+5wn2dGL3fdnlJPj7IOZbSvwxmbwuneidmkPqZyR5PnOAdVEOt+rpHMFbnUM3Am9s
	 t1lgz+ybVK4crB1hAL/16VbQfP0D/sXu3pSh0lwXuStfaBfi7mqkizLjIYqQGRO7US
	 Y7wRQUY/s3Tp0FNtSovREFfncbCefgjKYd3wiJTD1TP0kKqBqWbg+3WhjSVpOgfOS4
	 DGF3Csj7YQTfK4GU+9mfP4OVXbT7EYUOHJci27x/aiZ8jN+/OYYyT6+qB+imLNb0MK
	 UxkvhMtamUJNA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 06 Jan 2025 20:16:24 +0100
X-ME-IP: 90.11.132.44
Message-ID: <2824a50f-33f8-4db0-a7c2-edc5d6ca12af@wanadoo.fr>
Date: Mon, 6 Jan 2025 20:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ext4: Fix an error handling path in
 ext4_mb_init_cache()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alex Tomas <alex@clusterfs.com>, Eric Sandeen <sandeen@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andreas Dilger <adilger@clusterfs.com>, linux-ext4@vger.kernel.org
References: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
 <9383bdd6-ac04-4a14-aec1-bb65b67ace75@stanley.mountain>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9383bdd6-ac04-4a14-aec1-bb65b67ace75@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/01/2025 à 12:35, Dan Carpenter a écrit :
> On Fri, Jan 03, 2025 at 02:59:16PM +0100, Christophe JAILLET wrote:
>> 'bhs' is an un-initialized pointer.
>> If 'groups_per_page' == 1, 'bh' is assigned its address.
>>
>> Then, in the for loop below, if we early exit, either because
>> "group >= ngroups" or if ext4_get_group_info() fails, then it is still left
>> un-initialized.
>>
>> It can then be used.
>> NULL tests could fail and lead to unexpected behavior. Also, should the
>> error handling path be called, brelse() would be passed a potentially
>> invalid value.
>>
>> Better safe than sorry, just make sure it is correctly initialized to NULL.
>>
>> Fixes: c9de560ded61 ("ext4: Add multi block allocator for ext4")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>>
>> The scenario looks possible, but I don't know if it can really happen...
> 

Hi Dan,

> A pointer to the stack can't ever equal the address of the heap so this
> can't happen and it should not have a Fixes tag.

Not sure to understand what you mean.

I agree with your statement, but my point is that a pointer in the stack 
(and not *to* the stack) (i.e. 'bhs'), if not initialized, could in 
theory be anything. Let consider its value is 0xdeadbeef.

Then, if groups_per_page == 1, 'bh' points to the stack. Its value is 
"&bhs". And "bh[0]" is 0xdeadbeef.


Should ext4_get_group_info() fail on the first (and only) iteration of 
the for loop, then we 'continue'.
So the loop is done, and bh[0] is never updated, so still points to a 
memory holding 0xdeadbeef.

On the next for loop, on the first (and only) iteration, bh[0] is not 
NULL (it is 0xdeadbeef), so we call:
	ext4_wait_block_bitmap(..., 0xdeadbeef);

If we branch to the error handling path, it would also lead to calling
	brelse(bh[0]), that is to say brelse(0xdeadbeef);


Hoping my analysis is correct, I hope my reasoning is clearer.


That's the theory.
In practice, see below. Certainly harmless thanks to compilers, but 
still a UB for me, so should need a Fixes and a backport (it can't hurt 
anyway) to fix the theory.

> Setting the pointer to NULL probably silences a static checker warning
> and these days everyone automatically zeroes stack data so it doesn't
> affect the compiled code.

Agreed, but unless we have a explicit gcc flag to ask for that behavior 
(I've not checked if it is already the case), it looks like an UB for me.

> However generally we generally say that we
> should fix the checker instead.

In this particular case, the checker is just me, not an static analysis 
tool :).

I looked at this place because one of my coccinelle script spotted:

	/* allocate buffer_heads to read bitmaps */
	if (groups_per_page > 1) {
		i = sizeof(struct buffer_head *) * groups_per_page;
		bh = kzalloc(i, gfp);

as a candidate for kcalloc().

The rest of the story is just by reading the code around it.

> 
> I've thought about this in Smatch for a while, and I think what I would
> do is say that kmalloc() returns memory that is unique.  Smatch tracks if
> variables are equal to each other and unique variables wouldn't be equal
> to anything that came earlier.  But I haven't actually tried to implement
> this.
> 
> regards,
> dan carpenter
> 


