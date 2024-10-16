Return-Path: <linux-ext4+bounces-4594-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443EE9A0BC0
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA33B26E90
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9070208982;
	Wed, 16 Oct 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NsVBIKIO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DCA9443;
	Wed, 16 Oct 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085923; cv=none; b=twCrnvsiI3jihCsCaS49AuF7UbKcs0wcPJ/A7nDuLw9Fp0m2LE8k9QU/Lm/F9AZNWrW+/Mlr5H9LmXLqUEatUdbd+vBgpp3rby0rx5X9NWj6EStyU6og1bk88rXWbrqMiTV56oJXor/iubt/HzP1J9cdwBzfDx9POJlO2yw53u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085923; c=relaxed/simple;
	bh=DlWq8gR3CRG7uCYYORrdzOtklO0fryMK9JwPHbunuqg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GMqb1Kq4iE4UQNH+PM6USVkpEKXaEMD/ZOE/7juoi7obIPEyeSe+deEk1z7KjfipRusNHzk60m2Y4v0rMcf3fl4K/4IOMsbzKgmpxb0Ztsg7isYWM6W8qwOqGnmQrwheIOsUoc2WW5qTCdpPWe3mbCJpXc4fZ7qTFrhejKvJGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NsVBIKIO; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
	From; bh=zqzXma1DvYWClG9gYW8l/S/20uedzSXjY0wSaaAxwgg=; b=NsVBIKI
	OR2gq/SZ42DU5IraFb4Bo14CWygAWfIBtkmHZB6eEGIwWgIm1RcbMtaZ3Kz6MVPT
	ielrj1D2foN1Pj3U2ZnzvCrCCxLBzUgfdgwd//PjmJFbdex4W2/rGzdEK/kKOoPg
	1bbq4qpt+hFD/IJ5zYYlVVDoKd1aE5I2lfI8=
Received: from [192.168.22.184] (unknown [223.70.253.255])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD33x68wQ9nSdwMBg--.54321S2;
	Wed, 16 Oct 2024 21:38:05 +0800 (CST)
Content-Type: multipart/mixed; boundary="------------nnW36l4duVPFDrQSyC0OLokV"
Message-ID: <908502d6-cb0c-44ae-8c03-9a22c8c7fbf2@163.com>
Date: Wed, 16 Oct 2024 21:38:03 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, zhangshida@kylinos.cn,
 longzhi@sangfor.com.cn, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
 <20241016103301.rl6qngi2fb6yxjin@quack3>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20241016103301.rl6qngi2fb6yxjin@quack3>
X-CM-TRANSID:_____wD33x68wQ9nSdwMBg--.54321S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45Gr4DWr47AryUuFy8Zrb_yoWrKryxpF
	yakw47Gr1qyr9rArnrXF48XFWUK348Xry7GryUKrn3Z3y5Crna9F48try0k34DCrWkG3WF
	gr4UAryDCr1qy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U39N-UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbBDgZ6ymcPt4nR9QAAsK

This is a multi-part message in MIME format.
--------------nnW36l4duVPFDrQSyC0OLokV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Hello,
> I reviewed the patch attached in your email. The issue you mentioned about clearing buffer_new(bh) in write_end_fn() is indeed a bug.
> However, this patch does not resolve the crash issue we encountered.
> 
> Let me explain my analysis in detail below.
> The crash occurs in the function jbd2_journal_dirty_metadata().
> 
> ext4_block_write_begin() -> ext4_journalled_zero_new_buffers() -> write_end_fn()
>  -> ext4_dirty_journalled_data() -> ext4_handle_dirty_metadata() -> __ext4_handle_dirty_metadata()
>  -> jbd2_journal_dirty_metadata()
> 
> In the function jbd2_journal_dirty_metadata(), there is the following condition:
> —---------------------------------------------------------------------------------------------------
>         if (data_race(jh->b_transaction != transaction &&
>             jh->b_next_transaction != transaction)) {
>                 spin_lock(&jh->b_state_lock);
>                 J_ASSERT_JH(jh, jh->b_transaction == transaction ||
>                                 jh->b_next_transaction == transaction);
>                 spin_unlock(&jh->b_state_lock);
>         }
> ----------------------------------------------------------------------------------------------------
> By analyzing the vmcore, I found that both jh->b_transaction and jh->b_next_transaction are NULL.
> Through code analysis, I discovered that the __jbd2_journal_file_buffer() function adds the corresponding transaction of bh to jh->b_transaction.
> Normally, this is accessed through do_journal_get_write_access(), which can call __jbd2_journal_file_buffer().
> The detailed function call process is as follows:
> do_journal_get_write_access() -> ext4_journal_get_write_access() -> __ext4_journal_get_write_access()
>  -> jbd2_journal_get_write_access() -> do_get_write_access() -> __jbd2_journal_file_buffer()
>  
> 
> Therefore, resolving the crash issue requires obtaining write access before calling the jbd2_journal_dirty_metadata() function.
> The comment at the definition of the jbd2_journal_dirty_metadata() function also states: 
> 	'The buffer must have previously had jbd2_journal_get_write_access().'
> 
> In the ext4_block_write_begin() function, if get_block() encounters an error, then neither bh->b_this_page nor the subsequent bh calls do_journal_get_write_access().
> If bh->b_this_page and the subsequent bh are in the new state, it will lead to a crash when reaching the jbd2_journal_dirty_metadata() function.
> 	
> So, there are two ways to resolve this crash issue:
> 1、Call do_journal_get_write_access() on bh that is not handled due to get_block() error.
> 	The patch modification is in the attachment 0001-ext4-fix-a-assertion-failure-due-to-ungranted-bh-dir.patch.
> 
> 2、Call clear_buffer_new() on bh that is not handled due to get_block() error.
> 	The patch modification is in the attachment 0001-ext4-fix-a-assertion-failure-due-to-bh-not-clear-new.patch.
> 
> Additionally, I have found a method to quickly reproduce this crash issue.
> For details, please refer to the email I previously sent you: “https://lore.kernel.org/all/bd41c24b-7325-4584-a965-392a32e32c74@163.com/”.
> I have verified that this quick reproduction method works for both solutions to resolve the issue.
> 
> Please continue to consider which method is better to resolve this issue. 
> If you think that using clear_buffer_new() is a better solution, I can resend the patch via git send-mail.



在 2024/10/16 18:33, Jan Kara 写道:
> Hello,
> 
> On Fri 11-10-24 12:08:58, Baolin Liu wrote:
>> Greetings，
>>
>> This problem is reproduced by our customer using their own testing tool
>> “run_bug”. When I consulted with a client, the testing tool “run_bug”
>> used a variety of background programs to benchmark (including memory
>> pressure, cpu pressure, file cycle manipulation, fsstress Stress testing
>> tool, postmark program，and so on).
>>
>> The recurrence probability is relatively low.
> 
> OK, thanks for asking!
> 
>> In response to your query, in ext4_block_write_begin, the new state will
>> be clear before get block, and the bh that failed get_block will not be
>> set to new. However, when the page size is greater than the block size, a
>> page will contain multiple bh.
> 
> True. I wanted to argue that the buffer_new bit should be either cleared in
> ext4_block_write_begin() (in case of error) or in
> ext4_journalled_write_end() (in case of success) but actually
> ext4_journalled_write_end() misses the clearing. So I think the better
> solution is like the attached patch. I'll submit it once testing finishes
> but it would be great if you could test that it fixes your problems as
> well. Thanks!
> 
> 								Honza

--------------nnW36l4duVPFDrQSyC0OLokV
Content-Type: text/plain; charset=UTF-8;
 name="0001-ext4-fix-a-assertion-failure-due-to-bh-not-clear-new.patch"
Content-Disposition: attachment;
 filename*0="0001-ext4-fix-a-assertion-failure-due-to-bh-not-clear-new.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjYmVkNTIyY2NiNjk1NjgxZDk0ZWMwMjk0MGU5NThmY2Y3N2U1OGNkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCYW9saW4gTGl1IDxsaXViYW9saW5Aa3lsaW5vcy5j
bj4KRGF0ZTogV2VkLCA5IE9jdCAyMDI0IDA5OjMwOjM0ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gZXh0NDogZml4IGEgYXNzZXJ0aW9uIGZhaWx1cmUgZHVlIHRvIGJoIG5vdCBjbGVhciBu
ZXcKClNpbmNlIHRoZSBtZXJnZSBvZiBjb21taXQgMzkxMGI1MTNmY2RmICgiZXh0NDogcGVy
c2lzdCB0aGUgbmV3IHVwdG9kYXRlCmJ1ZmZlcnMgaW4gZXh0NF9qb3VybmFsbGVkX3plcm9f
bmV3X2J1ZmZlcnMiKSwgYSBuZXcgYXNzZXJ0aW9uIGZhaWx1cmUKb2NjdXJyZWQgdW5kZXIg
YSBvbGQga2VybmVsKGV4dDMsIGRhdGE9am91cm5hbCwgcGFnZXNpemU9NjRrKSB3aXRoCmNv
cnJlc3BvbmRpbmcgcG9ydGVkIHBhdGNoZXM6Cj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KQ2FsbCB0cmFjZToKICBf
X2V4dDRfaGFuZGxlX2RpcnR5X21ldGFkYXRhKzB4MzIwLzB4N2U4CiAgd3JpdGVfZW5kX2Zu
KzB4NzgvMHgxNzgKICBleHQ0X2pvdXJuYWxsZWRfemVyb19uZXdfYnVmZmVycysweGQwLzB4
MmM4CiAgZXh0NF9ibG9ja193cml0ZV9iZWdpbisweDg1MC8weGMwMAogIGV4dDRfd3JpdGVf
YmVnaW4rMHgzMzQvMHhjNjgKICBnZW5lcmljX3BlcmZvcm1fd3JpdGUrMHgxYTQvMHgzODAK
ICBleHQ0X2J1ZmZlcmVkX3dyaXRlX2l0ZXIrMHgxODAvMHgzNzAKICBleHQ0X2ZpbGVfd3Jp
dGVfaXRlcisweDE5NC8weGZjMAogIG5ld19zeW5jX3dyaXRlKzB4MzM4LzB4NGI4CiAgX192
ZnNfd3JpdGUrMHhjNC8weGU4CiAgdmZzX3dyaXRlKzB4MTJjLzB4M2QwCiAga3N5c193cml0
ZSsweGY0LzB4MjMwCiAgc3lzX3dyaXRlKzB4MzQvMHg0OAogIGVsMF9zdmNfbmFrZWQrMHg0
NC8weDQ4Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KCndoaWNoIHdhcyBjYXVzZWQgYnkgYmggZGlydGluZyB3aXRo
b3V0IGNhbGxpbmcgY2xlYXJfYnVmZmVyX25ldygpLgoKSW4gdGhlIGxvb3AgZm9yIGFsbCBi
aHMgb2YgYSBwYWdlIGluIGV4dDRfYmxvY2tfd3JpdGVfYmVnaW4oKSwKd2hlbiBhIGVyciBv
Y2N1cnJlZCwgaXQgd2lsbCBqdW1wIG91dCBvZiBsb29wLgpCdXQgdGhhdCB3aWxsIGxlYXZl
cyBzb21lIGJocyBiZWluZyBwcm9jZXNzZWQgYW5kIHNvbWUgbm90LAp3aGljaCB3aWxsIGxl
YWQgdG8gdGhlIGFzc2VyaW9uIGZhaWx1cmUgaW4gY2FsbGluZyB3cml0ZV9lbmRfZm4oKS4K
ClRvIGZpeGVkIHRoYXQsIGNsZWFyX2J1ZmZlcl9uZXcgZm9yIHRoZSByZXN0IHVucHJvY2Vz
c2VkIGJocywganVzdAphcyB3aGF0IHdyaXRlX2VuZF9mbiBkby4KCkZpeGVzOiAzOTEwYjUx
M2ZjZGYgKCJleHQ0OiBwZXJzaXN0IHRoZSBuZXcgdXB0b2RhdGUgYnVmZmVycyBpbiBleHQ0
X2pvdXJuYWxsZWRfemVyb19uZXdfYnVmZmVycyIpClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6
IFpoaSBMb25nIDxsb25nemhpQHNhbmdmb3IuY29tLmNuPgpTdWdnZXN0ZWQtYnk6IFNoaWRh
IFpoYW5nIDx6aGFuZ3NoaWRhQGt5bGlub3MuY24+ClNpZ25lZC1vZmYtYnk6IEJhb2xpbiBM
aXUgPGxpdWJhb2xpbkBreWxpbm9zLmNuPgotLS0KIGZzL2V4dDQvaW5vZGUuYyB8IDE2ICsr
KysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXh0NC9pbm9kZS5jIGIvZnMvZXh0NC9pbm9k
ZS5jCmluZGV4IDU0YmRkNDg4NGZlNi4uMjZjMTA3ZTA4M2M2IDEwMDY0NAotLS0gYS9mcy9l
eHQ0L2lub2RlLmMKKysrIGIvZnMvZXh0NC9pbm9kZS5jCkBAIC0xMTAyLDkgKzExMDIsMjMg
QEAgaW50IGV4dDRfYmxvY2tfd3JpdGVfYmVnaW4oaGFuZGxlX3QgKmhhbmRsZSwgc3RydWN0
IGZvbGlvICpmb2xpbywKIAkJCWVyciA9IC1FSU87CiAJfQogCWlmICh1bmxpa2VseShlcnIp
KSB7Ci0JCWlmIChzaG91bGRfam91cm5hbF9kYXRhKQorCQlpZiAoc2hvdWxkX2pvdXJuYWxf
ZGF0YSkgeworCQkJaWYgKGJoICE9IGhlYWQgfHwgIWJsb2NrX3N0YXJ0KSB7CisJCQkJZG8g
eworCQkJCQlibG9ja19lbmQgPSBibG9ja19zdGFydCArIGJoLT5iX3NpemU7CisKKwkJCQkJ
aWYgKGJ1ZmZlcl9uZXcoYmgpKQorCQkJCQkJaWYgKGJsb2NrX2VuZCA+IGZyb20gJiYgYmxv
Y2tfc3RhcnQgPCB0bykKKwkJCQkJCQljbGVhcl9idWZmZXJfbmV3KGJoKTsKKworCQkJCQli
bG9ja19zdGFydCA9IGJsb2NrX2VuZDsKKwkJCQkJYmggPSBiaC0+Yl90aGlzX3BhZ2U7CisJ
CQkJfSB3aGlsZSAoYmggIT0gaGVhZCk7CisJCQl9CisKIAkJCWV4dDRfam91cm5hbGxlZF96
ZXJvX25ld19idWZmZXJzKGhhbmRsZSwgaW5vZGUsIGZvbGlvLAogCQkJCQkJCSBmcm9tLCB0
byk7CisJCX0KIAkJZWxzZQogCQkJZm9saW9femVyb19uZXdfYnVmZmVycyhmb2xpbywgZnJv
bSwgdG8pOwogCX0gZWxzZSBpZiAoZnNjcnlwdF9pbm9kZV91c2VzX2ZzX2xheWVyX2NyeXB0
byhpbm9kZSkpIHsKLS0gCjIuMzkuMgoK
--------------nnW36l4duVPFDrQSyC0OLokV
Content-Type: text/plain; charset=UTF-8;
 name="0001-ext4-fix-a-assertion-failure-due-to-ungranted-bh-dir.patch"
Content-Disposition: attachment;
 filename*0="0001-ext4-fix-a-assertion-failure-due-to-ungranted-bh-dir.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlOTliY2U1NThkZGNjOThlMjQ5NTI4MGUxYWYwZGVlMzcyZmFlNjE5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCYW9saW4gTGl1IDxsaXViYW9saW5Aa3lsaW5vcy5j
bj4KRGF0ZTogV2VkLCA5IE9jdCAyMDI0IDA5OjMwOjM0ICswODAwClN1YmplY3Q6IFtQQVRD
SCB2MV0gZXh0NDogZml4IGEgYXNzZXJ0aW9uIGZhaWx1cmUgZHVlIHRvIHVuZ3JhbnRlZCBi
aCBkaXJ0aW5nCgpTaW5jZSB0aGUgbWVyZ2Ugb2YgY29tbWl0IDM5MTBiNTEzZmNkZiAoImV4
dDQ6IHBlcnNpc3QgdGhlIG5ldyB1cHRvZGF0ZQpidWZmZXJzIGluIGV4dDRfam91cm5hbGxl
ZF96ZXJvX25ld19idWZmZXJzIiksIGEgbmV3IGFzc2VydGlvbiBmYWlsdXJlCm9jY3VycmVk
IHVuZGVyIGEgb2xkIGtlcm5lbChleHQzLCBkYXRhPWpvdXJuYWwsIHBhZ2VzaXplPTY0aykg
d2l0aApjb3JyZXNwb25kaW5nIHBvcnRlZCBwYXRjaGVzOgo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CkNhbGwgdHJh
Y2U6CiAgX19leHQ0X2hhbmRsZV9kaXJ0eV9tZXRhZGF0YSsweDMyMC8weDdlOAogIHdyaXRl
X2VuZF9mbisweDc4LzB4MTc4CiAgZXh0NF9qb3VybmFsbGVkX3plcm9fbmV3X2J1ZmZlcnMr
MHhkMC8weDJjOAogIGV4dDRfYmxvY2tfd3JpdGVfYmVnaW4rMHg4NTAvMHhjMDAKICBleHQ0
X3dyaXRlX2JlZ2luKzB4MzM0LzB4YzY4CiAgZ2VuZXJpY19wZXJmb3JtX3dyaXRlKzB4MWE0
LzB4MzgwCiAgZXh0NF9idWZmZXJlZF93cml0ZV9pdGVyKzB4MTgwLzB4MzcwCiAgZXh0NF9m
aWxlX3dyaXRlX2l0ZXIrMHgxOTQvMHhmYzAKICBuZXdfc3luY193cml0ZSsweDMzOC8weDRi
OAogIF9fdmZzX3dyaXRlKzB4YzQvMHhlOAogIHZmc193cml0ZSsweDEyYy8weDNkMAogIGtz
eXNfd3JpdGUrMHhmNC8weDIzMAogIHN5c193cml0ZSsweDM0LzB4NDgKICBlbDBfc3ZjX25h
a2VkKzB4NDQvMHg0OAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cgp3aGljaCB3YXMgY2F1c2VkIGJ5IGJoIGRpcnRp
bmcgd2l0aG91dCBjYWxsaW5nCmRvX2pvdXJuYWxfZ2V0X3dyaXRlX2FjY2VzcygpLgoKSW4g
dGhlIGxvb3AgZm9yIGFsbCBiaHMgb2YgYSBwYWdlIGluIGV4dDRfYmxvY2tfd3JpdGVfYmVn
aW4oKSwKd2hlbiBhIGVyciBvY2N1cnJlZCwgaXQgd2lsbCBqdW1wIG91dCBvZiBsb29wLgpC
dXQgdGhhdCB3aWxsIGxlYXZlcyBzb21lIGJocyBiZWluZyBwcm9jZXNzZWQgYW5kIHNvbWUg
bm90LAp3aGljaCB3aWxsIGxlYWQgdG8gdGhlIGFzc2VyaW9uIGZhaWx1cmUgaW4gY2FsbGlu
ZyB3cml0ZV9lbmRfZm4oKS4KClRvIGZpeGVkIHRoYXQsIGdldCB3cml0ZSBhY2Nlc3MgZm9y
IHRoZSByZXN0IHVucHJvY2Vzc2VkIGJocywganVzdAphcyB3aGF0IHdyaXRlX2VuZF9mbiBk
by4KCkZpeGVzOiAzOTEwYjUxM2ZjZGYgKCJleHQ0OiBwZXJzaXN0IHRoZSBuZXcgdXB0b2Rh
dGUgYnVmZmVycyBpbiBleHQ0X2pvdXJuYWxsZWRfemVyb19uZXdfYnVmZmVycyIpClJlcG9y
dGVkLWFuZC10ZXN0ZWQtYnk6IFpoaSBMb25nIDxsb25nemhpQHNhbmdmb3IuY29tLmNuPgpT
dWdnZXN0ZWQtYnk6IFNoaWRhIFpoYW5nIDx6aGFuZ3NoaWRhQGt5bGlub3MuY24+ClNpZ25l
ZC1vZmYtYnk6IEJhb2xpbiBMaXUgPGxpdWJhb2xpbkBreWxpbm9zLmNuPgotLS0KIGZzL2V4
dDQvaW5vZGUuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5v
ZGUuYyBiL2ZzL2V4dDQvaW5vZGUuYwppbmRleCA1NGJkZDQ4ODRmZTYuLmE3MmY5NTEyODhl
NCAxMDA2NDQKLS0tIGEvZnMvZXh0NC9pbm9kZS5jCisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpA
QCAtMTEwMiw5ICsxMTAyLDI0IEBAIGludCBleHQ0X2Jsb2NrX3dyaXRlX2JlZ2luKGhhbmRs
ZV90ICpoYW5kbGUsIHN0cnVjdCBmb2xpbyAqZm9saW8sCiAJCQllcnIgPSAtRUlPOwogCX0K
IAlpZiAodW5saWtlbHkoZXJyKSkgewotCQlpZiAoc2hvdWxkX2pvdXJuYWxfZGF0YSkKKwkJ
aWYgKHNob3VsZF9qb3VybmFsX2RhdGEpIHsKKwkJCWlmIChiaCAhPSBoZWFkIHx8ICFibG9j
a19zdGFydCkgeworCQkJCWRvIHsKKwkJCQkJYmxvY2tfZW5kID0gYmxvY2tfc3RhcnQgKyBi
aC0+Yl9zaXplOworCisJCQkJCWlmIChidWZmZXJfbmV3KGJoKSkKKwkJCQkJCWlmIChibG9j
a19lbmQgPiBmcm9tICYmIGJsb2NrX3N0YXJ0IDwgdG8pCisJCQkJCQkJZG9fam91cm5hbF9n
ZXRfd3JpdGVfYWNjZXNzKGhhbmRsZSwKKwkJCQkJCQkJCQkgICAgaW5vZGUsIGJoKTsKKwor
CQkJCQlibG9ja19zdGFydCA9IGJsb2NrX2VuZDsKKwkJCQkJYmggPSBiaC0+Yl90aGlzX3Bh
Z2U7CisJCQkJfSB3aGlsZSAoYmggIT0gaGVhZCk7CisJCQl9CisKIAkJCWV4dDRfam91cm5h
bGxlZF96ZXJvX25ld19idWZmZXJzKGhhbmRsZSwgaW5vZGUsIGZvbGlvLAogCQkJCQkJCSBm
cm9tLCB0byk7CisJCX0KIAkJZWxzZQogCQkJZm9saW9femVyb19uZXdfYnVmZmVycyhmb2xp
bywgZnJvbSwgdG8pOwogCX0gZWxzZSBpZiAoZnNjcnlwdF9pbm9kZV91c2VzX2ZzX2xheWVy
X2NyeXB0byhpbm9kZSkpIHsKLS0gCjIuMzkuMgoK

--------------nnW36l4duVPFDrQSyC0OLokV--


