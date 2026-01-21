Return-Path: <linux-ext4+bounces-13148-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOkHLAyZcGlyYgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13148-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 10:14:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7067542C7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F42868A503
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E43446B1;
	Wed, 21 Jan 2026 09:04:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9630E835
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986259; cv=none; b=iwsCXzLmSIx0xT0acJhqVqO5wTDNALqPAXoGEkamvrglim4yW3NSFI2fzMRj+XqYyiU+UtY8yesjOor469boDv3G+20FVlHRejnyLBWuDWFzeD6LVrmsdHtnUTMh0eoS8M0z3OitECrMeHdu8RhvAzpVox7I+A0SOrDvEbsX/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986259; c=relaxed/simple;
	bh=xB6jeBv6oF4f2yIJ3xXPBdyhs5K0loI1TiXGUWL96lc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kMesyL3vnYkDFcm2pE6s0vrPicLO8Y6Yfk5lSr2Ai0HR8vG4K5aJmE0b2tk1pz1Yk0Aa/XcclgWn/4QuT6HklJjoriyUNXvuvfXojEnizUEPh56h0UdD8OwDsSPC3rfKu0p1dKxdulKCWQ2sDaZ9krXfDdPQWKsScN9dkX+ZJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwytM64nmzKHMj5
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 17:04:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CD2040539
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 17:04:13 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgB3JPWLlnBpwNZQEg--.36720S3;
	Wed, 21 Jan 2026 17:04:13 +0800 (CST)
Subject: Re: [PATCH] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <20260119131257.306564-1-yebin@huaweicloud.com>
 <aW9AofPgVKEL6bk1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jack@suse.cz
From: yebin <yebin@huaweicloud.com>
Message-ID: <6970968C.1050507@huaweicloud.com>
Date: Wed, 21 Jan 2026 17:04:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aW9AofPgVKEL6bk1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3JPWLlnBpwNZQEg--.36720S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xXF1rWFy5CF1UCr4DArb_yoW8tFy7p3
	yfKFWIkr1Y9F1Uuay7ur1DGa12qwsYgr1xJr17Ww1UXFy3t34IyrsrtrsY9F48uFW2ya1I
	vay5XFWYkrnakaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DMARC_NA(0.00)[huaweicloud.com];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-13148-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: D7067542C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/20 16:45, Ojaswin Mujoo wrote:
> On Mon, Jan 19, 2026 at 09:12:57PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
>>
>> EXT4_FS      KUNIT    EXT4_KUNIT_TESTS
>> Y              Y         Y
>> Y              Y         M
>> Y              M         M // This case will lead to link error
>> M              Y         M
>> M              M         M
>>
>> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e817a758801d..0fbd2dfae497 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -7191,6 +7191,10 @@ ext4_mballoc_query_range(
>>   	return error;
>>   }
>>
>> -#ifdef CONFIG_EXT4_KUNIT_TESTS
>> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
>> +#if IS_BUILTIN(CONFIG_EXT4_FS) && IS_MODULE(CONFIG_KUNIT)
>> +/* This case will lead to link error. */
>> +#else
>>   #include "mballoc-test.c"
>>   #endif
>> +#endif
>
> Hi Ye Bin,
>
> Thanks for pointing out this issue but your solution seems to be having
> a side effect of making ext4.ko depend on kunit.ko.
>
>    modinfo ext4.ko
>    license:        GPL
>    license:        GPL
>    description:    Fourth Extended Filesystem
>    author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
>    alias:          fs-ext4
>    alias:          ext3
>    alias:          fs-ext3
>    depends:        kunit
>    intree:         Y
>    name:           ext4
>    retpoline:      Y
>    vermagic:       6.19.0-rc4-xfstests-g326263653b81-dirty SMP preempt mod_unload
>
> That means we won't be able to insert ext4 module without having kunit.

Thank you for your reply.
In my opinion, if the CONFIG_EXT4_KUNIT_TESTS configuration is enabled 
and ext4.ko uses symbols from kunit.ko, then it is normal for ext4.ko to 
depend on kunit.ko.

> This is not the behavior we want. I think a more simpler fix here could
> be:
>
>    #if IS_BUILTIN(CONFIG_KUNIT) && IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
>    #include "mballoc-test.c"
>    #endif
>
> So basically, as long as KUNIT=y and EXT4_KUNIT_TESTS=y/m we will run
> these tests, otherwise we won't. This also removes the dependency issue.
>
> What do you think?
>
> Regards,
> ojaswin
>
>> --
>> 2.34.1
>>
>


