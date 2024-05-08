Return-Path: <linux-ext4+bounces-2353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D78BF430
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 03:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B470282DBD
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D48F6C;
	Wed,  8 May 2024 01:42:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC98F55;
	Wed,  8 May 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132565; cv=none; b=q1DDSeNoGrT5H1eKA5BImrIeml0U1HqnecgwFKEeBDWOLb8u5kSawGWRSVkllECklKBoDGZo4UfA28Ns6Q5B98o8F30uSZhly4eB/UzNrfECeCA+t7HCVdlYn+PFtcHqXznd3Hjx0PIyJq1sU2JNm6+L+ua/jJJ0ddtVnm8+D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132565; c=relaxed/simple;
	bh=oGoVz8s3KiR6LB2gCC4BsXs8Nv8ylpNu5HpFwvaB3T0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KICY+L+sbUbMzLFtk2Y18Y6jbUyB4rAt/ydqv88/yrPf7yyhedb3A0HkPcBxTr6dE7BXrCTCaXAhwwkneOtJyVnlh21XhzaWOTdxoxAiw0K7ENtsL5rUyiqurBU18KwgYfjoKM2ZOJy41oSog5q94diqdn57nmjA6c7sB6LbQ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYyZ650zXz4f3m7G;
	Wed,  8 May 2024 09:42:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 826771A08FD;
	Wed,  8 May 2024 09:42:32 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDH4QqH2DpmJeM7MA--.39785S2;
	Wed, 08 May 2024 09:42:32 +0800 (CST)
Subject: Re: [PATCH 2/9] jbd2: remove unused return info from
 jbd2_journal_write_metadata_buffer
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-3-shikemeng@huaweicloud.com>
 <97dbc0cd-5676-9e92-931c-5873f2e207cd@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ba9e9257-b309-17aa-9c1d-b4730bc2a91e@huaweicloud.com>
Date: Wed, 8 May 2024 09:42:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97dbc0cd-5676-9e92-931c-5873f2e207cd@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDH4QqH2DpmJeM7MA--.39785S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4DZFyUJw45GF18Kr1rWFg_yoW5ZFW3pr
	95Ga48AFyqvry8AFn7XFWDJFWj9ayjkFyjkr1qk3Z5ta15Jwn2gF1Iyr1a9r1jyF93Cw18
	AF1UC3yDGw4av3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUU
	UUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 5/7/2024 7:51 PM, Zhang Yi wrote:
> On 2024/5/6 22:17, Kemeng Shi wrote:
>> The done_copy_out info from jbd2_journal_write_metadata_buffer is not
>> used. Simply remove it.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/jbd2/journal.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 207b24e12ce9..068031f35aea 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -320,7 +320,6 @@ static void journal_kill_thread(journal_t *journal)
>>   *
>>   * On success:
>>   * Bit 0 set == escape performed on the data
>> - * Bit 1 set == buffer copy-out performed (kfree the data after IO)
>>   */
>>  
>>  int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>> @@ -455,7 +454,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>>  	set_buffer_shadow(bh_in);
>>  	spin_unlock(&jh_in->b_state_lock);
>>  
>> -	return do_escape | (done_copy_out << 1);
>> +	return do_escape;
>>  }
>>  
> 
> I checked the history, it seems that this bit has not been used since
> the very beginning when the jbd code was merged in, I suppose we could
> drop it. Since there is only one flag that is still in use, why not just
> drop the flag and pass out do_escape through an output parameter, or
> directly pass tag_flag, after that we could also drop the weird
> "if (flags & 1)" check in jbd2_journal_commit_transaction()?
Thanks for looking into this. I agree that the "flags & 1" is wired, I
wonder if we could further remove "flags & 1" with following change:

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..67077308b56b 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -353,7 +353,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
        struct buffer_head *descriptor;
        struct buffer_head **wbuf = journal->j_wbuf;
        int bufs;
-       int flags;
+       int escape;
        int err;
        unsigned long long blocknr;
        ktime_t start_time;
@@ -661,10 +661,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
                 */
                set_bit(BH_JWrite, &jh2bh(jh)->b_state);
                JBUFFER_TRACE(jh, "ph3: write metadata");
-               flags = jbd2_journal_write_metadata_buffer(commit_transaction,
+               escape = jbd2_journal_write_metadata_buffer(commit_transaction,
                                                jh, &wbuf[bufs], blocknr);
-               if (flags < 0) {
-                       jbd2_journal_abort(journal, flags);
+               if (escape < 0) {
+                       jbd2_journal_abort(journal, escape);
                        continue;
                }
                jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
@@ -673,7 +673,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
                    buffer */

                tag_flag = 0;
-               if (flags & 1)
+               if (escape)
                        tag_flag |= JBD2_FLAG_ESCAPE;
                if (!first_tag)
                        tag_flag |= JBD2_FLAG_SAME_UUID;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 08c59197c5bd..c8a1eca5caab 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -309,10 +309,8 @@ static void journal_kill_thread(journal_t *journal)
  *
  * Return value:
  *  <0: Error
- * >=0: Finished OK
- *
- * On success:
- * Bit 0 set == escape performed on the data
+ *  =0: Finished OK without escape
+ *  =1: Finished OK with escape
  */

Look forward to your reply.
Thanks.
Kemeng

> 
> Thanks,
> Yi.
> 


