Return-Path: <linux-ext4+bounces-13673-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEQlFnaGjGmfqAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13673-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 14:39:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D5124D7F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FF630293EE
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D428689A;
	Wed, 11 Feb 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHkWlHHr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE7253932
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817112; cv=none; b=dhtAy/gmAIgKMlLpI4/x2v8aTeYhzYpMKZwO7X0rj20ObSNeuXPygYkmfYuKBiRINTvHs8FSSwf/LbqSwdjHgA/HIdROrQDx17c2CTPAeUBXMWsWu84L4G5T+qxI1VbZFo7gBxj1xEP1rHMTz/pYn+XG9CuUK+DfH46AqiA3YZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817112; c=relaxed/simple;
	bh=3kr/X7EVzbCTl45y7tiiOecsEIRUyFN7X9DQHGs+Djw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaWYjGhVRFvkCIu2QDflHvQhQDb+iBm5H4wDD1Pa1hlQcDYkUJbwnAD2NN8qldMJjmiXrqwE0V6GuzoBUr8qTejvvzKy6KlENH37HWQY+OwCMjedS39lavGiKiv+N3PUYr8oq27UnEf2Vd2dG0ru32lEWhiXKrhzlHKbTdX1lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHkWlHHr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf91bbcd9so21888955ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770817111; x=1771421911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMvjs/DsalGRLabtIAjuej/4mud68+thdemO/4XZvPQ=;
        b=AHkWlHHrzG1//Ut+UL6Z/5E5mMAMvYW8I+7ejd9FiSADgrDion4MpMHIpZ/quKVck0
         fH6id4FvXkKgcjrMSv17i78K/uqgNRZbvg1FBS3JzyoGjUOW1/WIn9QFC7NocLkBD/kL
         EU1sCrDWp/iagvsU9HaTf9bX6uu4BC5hOUL6e45yHN8qTTDXFVV3bbpTJTYrqJiEBASl
         d5Hiy4AXu5mTVVTKJE3C0c2ViH6h1uFsI9q51cAC049vIrQnaF0Xkznuaju3T3P6qVmX
         dmRKE/+pvOl0nQuq2aPwDYa9g1aSrRuVHDSYW01ylFD16Yr5g3nXz7DFv+7SNT20ROY5
         kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770817111; x=1771421911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMvjs/DsalGRLabtIAjuej/4mud68+thdemO/4XZvPQ=;
        b=YLww/CkBhMqUmKopk7h5xkxiVWyk+5CG8f824MGrCZKzeg5C9WXWx8hQ+FhEetzD+u
         p3GQa9iW+FDPt4nFrYAqfnXzn/o9wO3iRy3IY0jdAyizMZXkpreb2qIc1xUODEPLXMjV
         1WkLt+IlVgDZPkeHkmT5CvEVXVe9lhheL9tpjIzW4nzO+fVL8xRuai6oKCo7CJCffpPq
         HO7RY81st7XQAkwZXvbg6++Qbr5SsDZHDWy/cwEK+75vOldUIf0YDQzOc6+LyTqeLQIi
         okyn2UUCiQnin0vRM9t6h7IX7jASnBLbsSZ9qZqP1II/B7kUF8qtYxDJ0/KClCsxVf9W
         9aMw==
X-Gm-Message-State: AOJu0YwAo+D8bdb9iDSjDiXm7E1LVovnmmAbNuBZE1AnSHkxyQl1JEUQ
	hp9uz8CQCSWWYRAq3h1bNpCwFGG2hPoHSJmCfUNhSmv00ep0yjGrmZNe
X-Gm-Gg: AZuq6aKZ2QrbU5eZusRZmSHPld+DtecbH1e3lwX7RS3z4rqWm+yYTmLy0jwRWRAicSS
	eKg11vR5bveh4uDZC8zWHuCLCv3vgJq9zUqXX5oAcTaQpiwYK3P+fBnOLY+swsttgbgEhS7Hwj/
	fbUo9oQ8GjGWQs8ZXyP5IQl0Ev/fpeHWruNVDf0GvX0CS0SPs/OS2WNdtlNe2ArcVYavVyG9z5I
	xrZyufH+o/CLI2eKMg8hTpm0t1IJVJnZ6zIMeRYLhCEGQIPaTNOaUGEhJOLBpPs2nHM5mGn+N0r
	C7gBVgJFV1m99ocYeB2ZtiBZOVK+yZZSviZRK/4LWKkI8W4l3xqyFIPnQ+dCXMzl2goMt2HAIP+
	zRBFOyKwI0TOrIZkBM5eYsVlVfV3HQTxdWgZ12S244sYtb2ND0Sd+woZ15ftWlOgVlr4CA/VkRe
	oyAL9O3KC5H2J9BU5v5Munot5EwEPsoDn/fnC476HDnvNSG+CZtDEytEzquIGZYzZJ0T2duf9va
	A==
X-Received: by 2002:a17:902:ce90:b0:2a9:5c0b:e5d3 with SMTP id d9443c01a7336-2ab278045ebmr24703725ad.20.1770817110987;
        Wed, 11 Feb 2026 05:38:30 -0800 (PST)
Received: from ?IPV6:240e:390:a90:6d21:e579:6116:b665:1484? ([240e:390:a90:6d21:e579:6116:b665:1484])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984c0d8sm28723825ad.13.2026.02.11.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 05:38:30 -0800 (PST)
Message-ID: <b77acdf8-0320-4f69-8478-0e2665a0755a@gmail.com>
Date: Wed, 11 Feb 2026 21:38:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org,
 djwong@kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com, Zhang Yi <yi.zhang@huaweicloud.com>
References: <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
 <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
 <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
 <d8b84bb5-8fb4-48fe-9ccb-7a0b724eb4b9@gmail.com>
 <3dv6rb4223ngpj2duqm5smvmlpwhbvgyiksfkzmyfxhchejgon@eoo2kitdbdpq>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <3dv6rb4223ngpj2duqm5smvmlpwhbvgyiksfkzmyfxhchejgon@eoo2kitdbdpq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13673-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com,huaweicloud.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC9D5124D7F
X-Rspamd-Action: no action

On 2/11/2026 7:42 PM, Jan Kara wrote:
> On Wed 11-02-26 00:11:51, Zhang Yi wrote:
>> On 2/10/2026 10:07 PM, Jan Kara wrote:
>>> On Tue 10-02-26 20:02:51, Zhang Yi wrote:
>>>> On 2/9/2026 4:28 PM, Zhang Yi wrote:
>>>>> On 2/6/2026 11:35 PM, Jan Kara wrote:
>>>>>> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
>>>>>>> On 2/5/2026 11:05 PM, Jan Kara wrote:
>>>>>>>> So how about the following:
>>>>>>>
>>>>>>> Let me see, please correct me if my understanding is wrong, ana there are
>>>>>>> also some points I don't get.
>>>>>>>
>>>>>>>> We expand our io_end processing with the
>>>>>>>> ability to journal i_disksize updates after page writeback completes. Then
>>>>
>>>> While I was extending the end_io path of buffered_head to support updating
>>>> i_disksize, I found another problem that requires discussion.
>>>>
>>>> Supporting updates to i_disksize in end_io requires starting a handle, which
>>>> conflicts with the data=ordered mode because folios written back through the
>>>> journal process cannot initiate any handles; otherwise, this may lead to a
>>>> deadlock. This limitation does not affect the iomap path, as it does not use
>>>> the data=ordered mode at all.  However, in the buffered_head path, online
>>>> defragmentation (if this change works, it should be the last user) still uses
>>>> the data=ordered mode.
>>>
>>> Right and my intention was to use reserved handle for the i_disksize update
>>> similarly as we currently use reserved handle for unwritten extent
>>> conversion after page writeback is done.
>>
>> IIUC, reserved handle only works for ext4_jbd2_inode_add_wait(). It doesn't
>> work for ext4_jbd2_inode_add_write() because writebacks triggered by the
>> journaling process cannot initiate any handles, including reserved handles.
> 
> Yes, we cannot start any new handles (reserved or not) from writeback
> happening from jbd2 thread. I didn't think about that case so good catch.
> So we can either do this once we have delay map and get rid of data=ordered
> mode altogether or, as you write below, we have to submit the tail folios
> proactively during truncate up / append write - but I don't like this
> option too much because workloads appending to file by small chunks (say a
> few bytes) will get a large performance hit from this.
> 

Yeah, so let's keep the buffered_head path as it is now, and only modify 
the iomap path to support the new post-EOF block zeroing solution for 
truncate up and append write as discussed.

Cheers,
Yi.

>> So, I guess you're suggesting that within mext_move_extent(), we should
>> proactively submit the blocks after swapping, and then call
>> ext4_jbd2_inode_add_wait() to replace the existing
>> ext4_jbd2_inode_add_write(). Is that correct?
> 
> 								Honza


