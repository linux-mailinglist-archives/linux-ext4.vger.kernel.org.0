Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5C623A8F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 04:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiKJDjj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 22:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiKJDji (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 22:39:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA39124
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 19:39:37 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N76yd72jgzmVnD;
        Thu, 10 Nov 2022 11:39:21 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:39:36 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:39:35 +0800
Content-Type: multipart/mixed;
        boundary="------------IqDqxF0gINu3Jx70pXlmpvFB"
Message-ID: <f56b7a5e-4c37-bbdb-5949-e6b18e0f0713@huawei.com>
Date:   Thu, 10 Nov 2022 11:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] e2fsck: The process is deadlocked
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <30ac384e-a015-259a-3efc-1c9f3ee1dabb@huawei.com>
 <Y2vKriGCf+qcOgoT@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <Y2vKriGCf+qcOgoT@mit.edu>
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500002.china.huawei.com (7.185.36.158) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--------------IqDqxF0gINu3Jx70pXlmpvFB
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Version is 1.46.4, I think whether to try to release the mutex lock
in the ext2fs_close_free, such as CACHE_MTX,BOUNCE_MTX,STATS_MTX. But
you need to decide if it's the device you're checking, because I've
checked everyplace where ext2fs_close_free is called, in addition to
the call in the program end and exception branch, it is also called
when the journal device is close.

Reliable reproducer is in attachment.

  -zhanchengbin.

On 2022/11/9 23:43, Theodore Ts'o wrote:
> On Wed, Nov 09, 2022 at 06:40:31PM +0800, zhanchengbin wrote:
>> Hi Tytso,
>> The process is deadlocked, and an I/O error occurs when logs
>> are replayed. Because in the I/O error handling function, I/O
>> is sent again and catch the mutexlock.
> 
> What version of e2fsprogs are you using, and do you have a reliable
> reproducer?
> 
> Thanks,
> 
> 					- Ted
> 
> .
> 
--------------IqDqxF0gINu3Jx70pXlmpvFB
Content-Type: text/plain; charset="UTF-8"; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKZGlzaz0ic2RiIgpkaXI9L21udC8ke2Rpc2t9Cm1rZnMuZXh0NCAtRiAv
ZGV2LyRkaXNrClsgLWQgJGRpciBdIHx8IG1rZGlyICRkaXIKCmVjaG8gMSA+IC9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxfbWFrZV9yZXF1ZXN0L3ZlcmJvc2UKZWNobyA1ID4gL3N5cy9rZXJu
ZWwvZGVidWcvZmFpbF9tYWtlX3JlcXVlc3QvcHJvYmFiaWxpdHkKZWNobyAxMCA+IC9zeXMv
a2VybmVsL2RlYnVnL2ZhaWxfbWFrZV9yZXF1ZXN0L2ludGVydmFsCmVjaG8gMTAwMDAwMDAg
PiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX21ha2VfcmVxdWVzdC90aW1lcwoKZnVuY3Rpb24g
c2V0X3N5cygpCnsKCWxvY2FsIHF1ZXVlX2Rpcj0vc3lzL2Jsb2NrLyQxL3F1ZXVlCglpbnRl
cnZhbD0kMgoJd2hpbGUgdHJ1ZQoJZG8KCQlzbGVlcCAkaW50ZXJ2YWwKCQlsZXQgc19udW09
UkFORE9NJTQKCQljYXNlICRzX251bSBpbgoJCQkwKQoJCQlzY2hlZHVsZXI9bXEtZGVhZGxp
bmUKCQkJOzsKCQkJMSkKCQkJc2NoZWR1bGVyPWJmcQoJCQk7OwoJCQkyKQoJCQlzY2hlZHVs
ZXI9a3liZXIKCQkJOzsKCQkJMykKCQkJc2NoZWR1bGVyPW5vbmUKCQkJOzsKCQllc2FjCgkJ
ZWNobyAkc2NoZWR1bGVyID4gJHF1ZXVlX2Rpci9zY2hlZHVsZXIKCWRvbmUKfQpzZXRfc3lz
ICRkaXNrIDEyMCAmPi9kZXYvbnVsbCAmCgppPTAKd2hpbGUgdHJ1ZQpkbwoJbGV0IGZsYWc9
aSU1CglpZiBbICRmbGFnIC1sZSAyIF07IHRoZW4KCQl0dW5lMmZzIC1sIC9kZXYvJGRpc2sg
fHwgZXhpdCAxCglmaQoKCW1vdW50IC1vIGVycm9ycz1yZW1vdW50LXJvIC9kZXYvJGRpc2sg
JGRpciB8fCBleGl0IDEKCXR1bmUyZnMgLWwgL2Rldi8kZGlzayB8fCBleGl0IDEKCWZzc3Ry
ZXNzIC1kICRkaXIvZnNzIC1sIDIwIC1uIDUwMCAtcCA4ID4gL2Rldi9udWxsIDI+JjEgJgoJ
c2xlZXAgJCgoMSArIFJBTkRPTSAlIDMpKQoJbW91bnQgfCBncmVwICRkaXIgfCBncmVwICco
cm8nICYmIGV4aXQgMQoKCWVjaG8gMSA+IC9zeXMvYmxvY2svJGRpc2svbWFrZS1pdC1mYWls
CglzbGVlcCAkKCgxICsgUkFORE9NICUgMykpCglwcyAtZSB8IGdyZXAgLXcgZnNzdHJlc3Mg
PiAvZGV2L251bGwgMj4mMQoJd2hpbGUgWyAkPyAtZXEgMCBdCglkbwoJCXNsZWVwIDEKCQlt
b3VudCB8IGdyZXAgJGRpciB8IGdyZXAgJyhybycgJiYga2lsbGFsbCAtOSBmc3N0cmVzcwoJ
CXBzIC1lIHwgZ3JlcCAtdyBmc3N0cmVzcyA+IC9kZXYvbnVsbCAyPiYxCglkb25lCgoJZWNo
byAwID4gL3N5cy9ibG9jay8kZGlzay9tYWtlLWl0LWZhaWwKCXdoaWxlIHRydWUKCWRvCgkJ
dW1vdW50ICRkaXIgJiYgYnJlYWsKCQlraWxsYWxsIC05IGZzc3RyZXNzID4gL2Rldi9udWxs
IDI+JjEKCQlzbGVlcCAwLjEKCWRvbmUKCglpZiBbICRmbGFnIC1sZSAxIF07IHRoZW4KCQl0
dW5lMmZzIC1sIC9kZXYvJGRpc2sgfHwgZXhpdCAxCglmaQoKCWVjaG8gMSA+IC9zeXMvYmxv
Y2svJGRpc2svbWFrZS1pdC1mYWlsCgllY2hvIDEwID4gL3N5cy9rZXJuZWwvZGVidWcvZmFp
bF9tYWtlX3JlcXVlc3QvcHJvYmFiaWxpdHkKCWVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVn
L2ZhaWxfbWFrZV9yZXF1ZXN0L2ludGVydmFsCgljb3VudD0xMDAKCXdoaWxlIFsgJGNvdW50
IC1nZSAwIF07IGRvCgkJZnNjayAtYSAvZGV2LyRkaXNrCgkJKChjb3VudCA9IGNvdW50IC0g
MSkpCglkb25lCgllY2hvIDUgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX21ha2VfcmVxdWVz
dC9wcm9iYWJpbGl0eQoJZWNobyAxMCA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxfbWFrZV9y
ZXF1ZXN0L2ludGVydmFsCgllY2hvIDAgPiAvc3lzL2Jsb2NrLyRkaXNrL21ha2UtaXQtZmFp
bAoKICAgICAgICBmc2NrIC1hIC9kZXYvJGRpc2sgJj4gZnNjay0ke2Rpc2t9LmxvZwogICAg
ICAgIHJldD0kPwogICAgICAgIGlmIFsgJHJldCAtbmUgMCAtYSAkcmV0IC1uZSAxIF07IHRo
ZW4KCQlleGl0IDEKICAgICAgICBmaQoKCWZzY2sgLWZuIC9kZXYvJGRpc2sKICAgICAgICBy
ZXQ9JD8KICAgICAgICBpZiBbICRyZXQgLW5lIDAgXTsgdGhlbgoJCWV4aXQgMQogICAgICAg
IGZpCgkoKGk9aSsxKSkKZG9uZQo=
--------------IqDqxF0gINu3Jx70pXlmpvFB--
