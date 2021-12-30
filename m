Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40E481AB0
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Dec 2021 09:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhL3IQR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Dec 2021 03:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhL3IQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Dec 2021 03:16:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D1C061574
        for <linux-ext4@vger.kernel.org>; Thu, 30 Dec 2021 00:16:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so48964209wrc.5
        for <linux-ext4@vger.kernel.org>; Thu, 30 Dec 2021 00:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=rJcq2wcLnWi971+gqj9g4Msp+/5ufH4ufnxnTfwdNag=;
        b=d+Q+xNpetq5YiHtgkR7y8VPlnHs7M6EyhozZkPBN1oEH+r/QoHAo7m8pakFBRv08Yj
         iSzKmP9tgqKNjYRWdsr3gQdkUk+4cZ9fYYPSk0kUDavGMot7zh6fHqDmkMnpIGf9HoSs
         qRwtJZB/m5uF3n7yJbsoHr44pQl3ZUWF0V3e+bCpUH27q40O8tSWYDitQkgrqcsYJfqv
         7+QP919wFpnt5+gg4Nkf3aXrHwTuHPo1L6xYsrJ0r+X3rxWlHznJjqhJDh+sMlSvvDZ3
         zTI6p6Tkh3a9iPp1+7xtKNDnyz6a/HwtIc+8XZNZjD5TdnMgVDrb8n5k7UcUe1J74D1I
         c/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=rJcq2wcLnWi971+gqj9g4Msp+/5ufH4ufnxnTfwdNag=;
        b=W8sXH2NGPPF+bNMKqjEJsdtpFB+177uhIufYbjhB5kilKl7lv1nmxylFyBNEf18sNF
         JEcn06IsufEhAEuXg3prHEJhpmuAXh+ssDpr6IGCtajcKvoECbjHCYXas7f+SRJ9mUza
         b1Q1QdwBidwbXvAu7o2H95XOytqcBs1WTieGlUDZobu2oYJn+0WL8GdLpgqY08gBOpR0
         /naWJRP7E4SE6m+MuA15yLBFOoR0Yu8rEqJoVVGkcUThQqtno0+fSL/bxWww9Tpq3bKj
         n5jRfvywPuCg2GuiYtItf6IgdUU4Q388Xpy3KoEGC5Zb5GKp15nC+Uw2IQ/5b9KUYWxc
         K6XA==
X-Gm-Message-State: AOAM532n79B5zdmmNxa+ns4DBc8N1n9IEgcL1huSvoAsdv7gUBQnJL6a
        dKZm0hWBOizr6hlC/KFnlY3yBw==
X-Google-Smtp-Source: ABdhPJyD/bPjR8JLMIh7CnkxN47gW5xL2cExuyMtpkjVW6l7Do7Edb8J2W4Tn6dasotFICaSMKp5Iw==
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr24777387wru.214.1640852175153;
        Thu, 30 Dec 2021 00:16:15 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:7100:bf30:d44a:7c:3046? (p200300d997087100bf30d44a007c3046.dip0.t-ipconnect.de. [2003:d9:9708:7100:bf30:d44a:7c:3046])
        by smtp.googlemail.com with ESMTPSA id j13sm28177804wmq.11.2021.12.30.00.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 00:16:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------5Nd0X35ghXa25IVWqhqYY2wi"
Message-ID: <8fe067d0-6d57-9dd7-2c10-5a2c34037ee1@colorfullife.com>
Date:   Thu, 30 Dec 2021 09:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: JBD2: journal transaction 6943 on loop0-8 is corrupt.
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 1vier1@web.de
References: <baa3101d-e2f7-823e-040f-8739ab610419@colorfullife.com>
 <Yc0NUYyRhLdtapq+@mit.edu>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <Yc0NUYyRhLdtapq+@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------5Nd0X35ghXa25IVWqhqYY2wi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ted,

On 12/30/21 02:37, Theodore Ts'o wrote:
> On Tue, Dec 28, 2021 at 09:36:22PM +0100, Manfred Spraul wrote:
>> Hi,
>>
>> with simulated power failures, I see a corrupted journal
>>
>> [39056.200845] JBD2: journal transaction 6943 on loop0-8 is corrupt.
>> [39056.200851] EXT4-fs (loop0): error loading journal
> This means that the journal replay found a commit which was *not* the
> last commit, and which contained a CRC error.  If it's the last commit
> (e.g., there is no valid subsequent commit block), then it's possible
> that the journal commit was never completed before the system crashed
> --- e.g., it was an interrupted commit.

It is the last commit, there are no valid subsequent commit blocks.

The current failure model is simple: all blocks up to block <n> are 
written, the blocks starting from <n+1> are discarded.

What I can't rule out, but I think this is not what I see:
The image is small (512 MB) and everything is in memory. Thus I would 
not rule out that the whole journal is filled within less than one second.
The commit header contains h_commit_sec and h_commit_nsec, but from what 
I see, do_one_pass() evaluates only h_commit_sec.


> Your test is aborting the commit at various points in the write I/O
> stream, so it should be simulating an interrupted commit (assuming
> that it's not corrupting any I/O.  So the jbd2 layer should have
> understood it was the last commit in the journal, and been OK with the
> checksum failure.

I think the jbd2 layer understood that it was the last commit - but it 
nevertheless failed the recovery.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/jbd2/recovery.c?h=v5.16-rc7#n809

> |
> 		if  (pass  ==  PASS_SCAN  &&
> 			!jbd2_commit_block_csum_verify(journal,
> 							bh->b_data))  {
> 			chksum_error:
> 				if  (commit_time  <  last_trans_commit_time)
> 					goto  ignore_crc_mismatch;
> 				info->end_transaction  =  next_commit_ID;
>
> 				if  (!jbd2_has_feature_async_commit(journal))  {
> 					journal->j_failed_commit  =
> 						next_commit_ID;
> 					brelse(bh);
> 					break;
> 				}
> 			}
> |

async_commit() is false.

journal->j_failed_commit is set, and thus after journal playback, a 
failure is reported :-(


What I have done:

- I have removed the line journal->j_failed_commit = next_commit_ID, 
then the image is mounted.

- I had added pr_info() lines, and this confirms that it starts with a 
failure of jbd2_block_csum_verify().

dmesg with JBD2 debug output and additional pr_info lines:

 >>>

[  748.591348] next_commit_id increased: 6943.
[  748.593397] fs/jbd2/recovery.c: (do_one_pass, 517): Scanning for 
sequence ID 6943 at 4544/8192
[  748.594322] fs/jbd2/recovery.c: (do_one_pass, 526): JBD2: checking 
block 4544
[  748.595879] fs/jbd2/recovery.c: (do_one_pass, 549): Found magic 5, 
sequence 6943
[  748.596800] fs/jbd2/recovery.c: (do_one_pass, 517): Scanning for 
sequence ID 6943 at 4545/8192
[  748.600073] fs/jbd2/recovery.c: (do_one_pass, 526): JBD2: checking 
block 4545
[  748.601398] fs/jbd2/recovery.c: (do_one_pass, 549): Found magic 1, 
sequence 6943
[  748.603481] fs/jbd2/recovery.c: (do_one_pass, 517): Scanning for 
sequence ID 6943 at 4574/8192
[  748.606238] fs/jbd2/recovery.c: (do_one_pass, 526): JBD2: checking 
block 4574
[  748.607241] fs/jbd2/recovery.c: (do_one_pass, 549): Found magic 2, 
sequence 6943
[  748.608248] commit_csum_verify error: provided 81be34bd.
[  748.610199] direct block verify error.
[  748.612327] chksum_error.
[  748.617616] error line 2.
[  748.622085] error line 3.
[  748.623291] fs/jbd2/recovery.c: (do_one_pass, 517): Scanning for 
sequence ID 6943 at 4575/8192
[  748.624133] fs/jbd2/recovery.c: (do_one_pass, 526): JBD2: checking 
block 4575
[  748.625134] done, info->end_transaction is 6943.
[  748.626966] done with update, info->end_transaction is 6943.
[  748.629521] next_commit_id: initial value 6799.
[  748.630836] fs/jbd2/recovery.c: (do_one_pass, 491): Starting recovery 
pass 1
[  748.631529] fs/jbd2/recovery.c: (do_one_pass, 517): Scanning for 
sequence ID 6799 at 6734/8192
[  748.633346] fs/jbd2/recovery.c: (do_one_pass, 526): JBD2: checking 
block 6734

<<<

What do you think?
Is JBD2 too aggressive in declaring something a journal corruption?

What is definitively correct is that the failure is minor. fsck -f was 
able to correct it.
Thus: What is your understanding:
If a mount command fails due to a journal corruption, should user space 
first try a fsck -f before giving up?


--

     Manfred

--------------5Nd0X35ghXa25IVWqhqYY2wi
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-jbd2-recovery.c-Continue-on-csum-failures-for-commit.patch"
Content-Disposition: attachment;
 filename*0="0001-jbd2-recovery.c-Continue-on-csum-failures-for-commit.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3NTkwNjJhMjExNzZjNDZhOGZjMWZhNGQ5NWUyMGM0NDUwYTEwYjlhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5mcmVkIFNwcmF1bCA8bWFuZnJlZEBjb2xvcmZ1
bGxpZmUuY29tPgpEYXRlOiBUaHUsIDMwIERlYyAyMDIxIDA4OjIyOjAwICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gamJkMi9yZWNvdmVyeS5jOiBDb250aW51ZSBvbiBjc3VtIGZhaWx1cmVz
IGZvciBjb21taXQgcmVjb3JkCgpOb3RpY2VkIHdpdGggc2ltdWxhdGVkIHBvd2VyIGZhaWx1
cmVzLCBpLmUuIG5vdCBvbiByZWFsIGhhcmR3YXJlOgoKVGhlIGZhaWx1cmUgbW9kZWwgaXM6
Ci0gNTEyIGJ5dGVzIHdyaXRlcyBhcmUgYXRvbWljLgotIExhcmdlciB3cml0ZXMgYXJlIG5v
dCBhdG9taWMuCi0gRXZlcnl0aGluZyBpcyB3cml0dGVuIGluIG9yZGVyLgoKU2luY2UgdGhl
IEpCRDIgYmxvY2sgc2l6ZSBjYW4gYmUgbGFyZ2VyIHRoYW4gdGhlIGJsb2NrIHNpemUgb2Yg
dGhlCnBoeXNpY2FsIGRyaXZlLCBpdCBtYXkgaGFwcGVuIHRoYXQgYSAoSkJEMikgYmxvY2sg
c3RhcnRzIHdpdGggdGhlCmV4cGVjdGVkIG1hZ2ljL2Jsb2NrIHR5cGU9PUpCRDJfQ09NTUlU
X0JMT0NLL3NlcXVlbmNlIG51bWJlci8KY29tbWl0IHRpbWUsIGJ1dCBuZXZlcnRoZWxlc3Mg
dGhlIGNzdW0gdmVyaWZpY2F0aW9uIGZhaWxzIGJlY2F1c2UKamJkMl9jb21taXRfYmxvY2tf
Y3N1bV92ZXJpZnkoKSBjYWxjdWxhdGVzIGEgY2hlY2tzdW0gb3Zlcgp0aGUgY29tcGxldGUg
SkJEMiBibG9jay4KClRodXM6IEp1c3QgZW5kIHRoZSBzY2FuIG9uIGEgY3N1bSBmYWlsdXJl
LgoKTm90ZTogVGhlIGNoYW5nZSBpcyBtb3N0IGxpa2VseSBpbmNvbXBsZXRlLiBUaGVyZSBh
cmUgcHJvYmFibHkKbW9yZSBzaXR1YXRpb25zIHdoZXJlIHRoZSBjb2RlIGFzc3VtZXMgdGhh
dCBhbiBpbmNvcnJlY3QgY3N1bQppcyBhbHdheXMgYSBjb3JydXB0aW9uLgoKLS0tCiBmcy9q
YmQyL3JlY292ZXJ5LmMgfCAyMSArKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L2piZDIvcmVjb3ZlcnkuYyBiL2ZzL2piZDIvcmVjb3ZlcnkuYwppbmRleCA4Y2EzNTI3MTg5
ZjguLmY2ZDU5YmMyMDRhMSAxMDA2NDQKLS0tIGEvZnMvamJkMi9yZWNvdmVyeS5jCisrKyBi
L2ZzL2piZDIvcmVjb3ZlcnkuYwpAQCAtNzA5LDYgKzcwOSwyMCBAQCBzdGF0aWMgaW50IGRv
X29uZV9wYXNzKGpvdXJuYWxfdCAqam91cm5hbCwKIAkJCS8qICAgICBIb3cgdG8gZGlmZmVy
ZW50aWF0ZSBiZXR3ZWVuIGludGVycnVwdGVkIGNvbW1pdAogCQkJICogICAgICAgICAgICAg
ICBhbmQgam91cm5hbCBjb3JydXB0aW9uID8KIAkJCSAqCisJCQkgKiBBc3N1bWU6IFBoeXNp
Y2FsIGJsb2NrIHNpemUgNTEyIGJ5dGVzLAorCQkJICogICAgICAgICBqLT5qX2Jsb2Nrc2l6
ZT0xMDI0CisJCQkgKiBJZiB0aGUgMXN0IHBoeXNpY2FsIGJsb2NrIG9mIGEgY29tbWl0IGJs
b2NrIGlzCisJCQkgKiB3cml0dGVuLCB0aGVuIHRoZSBjb3JyZWN0IG1hZ2ljL2Jsb2NrIHR5
cGUvCisJCQkgKiBzZXF1ZW5jZSBudW1iZXIvY29tbWl0IHRpbWUgd2lsbCBiZSB0aGVyZS4K
KwkJCSAqIElmIHRoZSAybmQgYmxvY2sgaXMgbm90IHdyaXR0ZW4sIHRoZW4gdGhlIGNzdW0K
KwkJCSAqIHZlcmlmaWNhdGlvbiB3aWxsIGZhaWwsIGJlY2F1c2UgdGhlIGNzdW0gaXMKKwkJ
CSAqIGNhbGN1bGF0ZWQgb3ZlciB0aGUgd2hvbGUgSkJEMiBibG9jay4KKwkJCSAqCisJCQkg
KiBUaHVzOiBPbmx5IG9ubHkgYXN5bmNfY29tbWl0LCBuLXRoIHRyYW5zYWN0aW9uIGZhaWxz
CisJCQkgKiBjc3VtIGNoZWNrLCAobisxKXRoIHRyYW5zYWN0aW9uIHBhc3NlcyBjc3VtIGNo
ZWNrLAorCQkJICogaXMgYSBqb3VybmFsIGNvcnJ1cHRpb24uIEV2ZXJ5dGhpbmcgZWxzZSBj
b3VsZCBiZQorCQkJICoganVzdCBhbiBpbnRlcnJ1cHRlZCB3cml0ZS4KKwkJCSAqCiAJCQkg
KiB7bnRoIHRyYW5zYWN0aW9ufQogCQkJICogICAgICAgIENoZWNrc3VtIFZlcmlmaWNhdGlv
biBGYWlsZWQKIAkJCSAqCQkJIHwKQEAgLTcxNyw3ICs3MzEsNyBAQCBzdGF0aWMgaW50IGRv
X29uZV9wYXNzKGpvdXJuYWxfdCAqam91cm5hbCwKIAkJCSAqIAlhc3luY19jb21taXQgICAg
ICAgICAgICAgc3luY19jb21taXQKIAkJCSAqICAgICAJCXwgICAgICAgICAgICAgICAgICAg
IHwKIAkJCSAqCQl8IEdPIFRPIE5FWFQgICAgIkpvdXJuYWwgQ29ycnVwdGlvbiIKLQkJCSAq
CQl8IFRSQU5TQUNUSU9OCisJCQkgKgkJfCBUUkFOU0FDVElPTiAgIG9yICJJbnRlcnJ1cHRl
ZCBDb21taXQiCiAJCQkgKgkJfAogCQkJICogeyhuKzEpdGggdHJhbnNhbmN0aW9ufQogCQkJ
ICoJCXwKQEAgLTgwNiw4ICs4MjAsOSBAQCBzdGF0aWMgaW50IGRvX29uZV9wYXNzKGpvdXJu
YWxfdCAqam91cm5hbCwKIAkJCQlpbmZvLT5lbmRfdHJhbnNhY3Rpb24gPSBuZXh0X2NvbW1p
dF9JRDsKIAogCQkJCWlmICghamJkMl9oYXNfZmVhdHVyZV9hc3luY19jb21taXQoam91cm5h
bCkpIHsKLQkJCQkJam91cm5hbC0+al9mYWlsZWRfY29tbWl0ID0KLQkJCQkJCW5leHRfY29t
bWl0X0lEOworCQkJCQkvKiBJbnRlcnJ1cHRlZCBjb21taXQgb3IgY29ycnVwdAorCQkJCQkg
KiBqb3VybmFsLiBBc3N1bWUgaW50ZXJydXB0ZWQgY29tbWl0LgorCQkJCQkgKi8KIAkJCQkJ
YnJlbHNlKGJoKTsKIAkJCQkJYnJlYWs7CiAJCQkJfQotLSAKMi4zMy4xCgo=
--------------5Nd0X35ghXa25IVWqhqYY2wi
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-DEBUG-patch-add-printk-to-fs-jbd2-recovery.c.patch"
Content-Disposition: attachment;
 filename="0003-DEBUG-patch-add-printk-to-fs-jbd2-recovery.c.patch"
Content-Transfer-Encoding: base64

RnJvbSA2OTNiY2Y2NTMxMmUyMDJjMTViMmYyOTFlMWQxMDViNTQ4NmNmZWI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5mcmVkIFNwcmF1bCA8bWFuZnJlZEBjb2xvcmZ1
bGxpZmUuY29tPgpEYXRlOiBUaHUsIDMwIERlYyAyMDIxIDA4OjAzOjA0ICswMTAwClN1Ympl
Y3Q6IFtQQVRDSCAzLzNdIERFQlVHIHBhdGNoOiBhZGQgcHJpbnRrIHRvIGZzL2piZDIvcmVj
b3ZlcnkuYwoKZGVidWcgcHJpbnRvdXRzLgoKLS0tCiBmcy9qYmQyL2pvdXJuYWwuYyAgfCAg
MiArLQogZnMvamJkMi9yZWNvdmVyeS5jIHwgMTMgKysrKysrKysrKysrKwogMiBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvamJkMi9qb3VybmFsLmMgYi9mcy9qYmQyL2pvdXJuYWwuYwppbmRleCAzNTMwMmJjMTky
ZWIuLjU4NTQ1ZmE3NGI5ZiAxMDA2NDQKLS0tIGEvZnMvamJkMi9qb3VybmFsLmMKKysrIGIv
ZnMvamJkMi9qb3VybmFsLmMKQEAgLTQ5LDcgKzQ5LDcgQEAKICNpbmNsdWRlIDxhc20vcGFn
ZS5oPgogCiAjaWZkZWYgQ09ORklHX0pCRDJfREVCVUcKLXVzaG9ydCBqYmQyX2pvdXJuYWxf
ZW5hYmxlX2RlYnVnIF9fcmVhZF9tb3N0bHk7Cit1c2hvcnQgamJkMl9qb3VybmFsX2VuYWJs
ZV9kZWJ1ZyBfX3JlYWRfbW9zdGx5ID0gOTk7CiBFWFBPUlRfU1lNQk9MKGpiZDJfam91cm5h
bF9lbmFibGVfZGVidWcpOwogCiBtb2R1bGVfcGFyYW1fbmFtZWQoamJkMl9kZWJ1ZywgamJk
Ml9qb3VybmFsX2VuYWJsZV9kZWJ1ZywgdXNob3J0LCAwNjQ0KTsKZGlmZiAtLWdpdCBhL2Zz
L2piZDIvcmVjb3ZlcnkuYyBiL2ZzL2piZDIvcmVjb3ZlcnkuYwppbmRleCA4Y2EzNTI3MTg5
ZjguLmI2Njg4NDc4NmNiOSAxMDA2NDQKLS0tIGEvZnMvamJkMi9yZWNvdmVyeS5jCisrKyBi
L2ZzL2piZDIvcmVjb3ZlcnkuYwpAQCAtNDI4LDYgKzQyOCw5IEBAIHN0YXRpYyBpbnQgamJk
Ml9jb21taXRfYmxvY2tfY3N1bV92ZXJpZnkoam91cm5hbF90ICpqLCB2b2lkICpidWYpCiAJ
aC0+aF9jaGtzdW1bMF0gPSAwOwogCWNhbGN1bGF0ZWQgPSBqYmQyX2Noa3N1bShqLCBqLT5q
X2NzdW1fc2VlZCwgYnVmLCBqLT5qX2Jsb2Nrc2l6ZSk7CiAJaC0+aF9jaGtzdW1bMF0gPSBw
cm92aWRlZDsKK2lmIChwcm92aWRlZCAhPSBjcHVfdG9fYmUzMihjYWxjdWxhdGVkKSkgewor
cHJfaW5mbygiY29tbWl0X2NzdW1fdmVyaWZ5IGVycm9yOiBwcm92aWRlZCAleC5cbiIsIHBy
b3ZpZGVkKTsKK30KIAogCXJldHVybiBwcm92aWRlZCA9PSBjcHVfdG9fYmUzMihjYWxjdWxh
dGVkKTsKIH0KQEAgLTQ3OCw2ICs0ODEsNyBAQCBzdGF0aWMgaW50IGRvX29uZV9wYXNzKGpv
dXJuYWxfdCAqam91cm5hbCwKIAogCXNiID0gam91cm5hbC0+al9zdXBlcmJsb2NrOwogCW5l
eHRfY29tbWl0X0lEID0gYmUzMl90b19jcHUoc2ItPnNfc2VxdWVuY2UpOworcHJfaW5mbygi
bmV4dF9jb21taXRfaWQ6IGluaXRpYWwgdmFsdWUgJXUuXG4iLCAodW5zaWduZWQgaW50KSBu
ZXh0X2NvbW1pdF9JRCk7CiAJbmV4dF9sb2dfYmxvY2sgPSBiZTMyX3RvX2NwdShzYi0+c19z
dGFydCk7CiAKIAlmaXJzdF9jb21taXRfSUQgPSBuZXh0X2NvbW1pdF9JRDsKQEAgLTc4Myw2
ICs3ODcsNyBAQCBzdGF0aWMgaW50IGRvX29uZV9wYXNzKGpvdXJuYWxfdCAqam91cm5hbCwK
IAkJCQkJYnJlbHNlKGJoKTsKIAkJCQkJYnJlYWs7CiAJCQkJfQorcHJfaW5mbygiY3JjMzJf
c3VtICV4IGZvdW5kX2NzdW0gJXguXG4iLCBjcmMzMl9zdW0sIGZvdW5kX2Noa3N1bSk7CiAK
IAkJCQkvKiBOZWl0aGVyIGNoZWNrc3VtIG1hdGNoIG5vciB1bnVzZWQ/ICovCiAJCQkJaWYg
KCEoKGNyYzMyX3N1bSA9PSBmb3VuZF9jaGtzdW0gJiYKQEAgLTgwMCwyMiArODA1LDI4IEBA
IHN0YXRpYyBpbnQgZG9fb25lX3Bhc3Moam91cm5hbF90ICpqb3VybmFsLAogCQkJaWYgKHBh
c3MgPT0gUEFTU19TQ0FOICYmCiAJCQkgICAgIWpiZDJfY29tbWl0X2Jsb2NrX2NzdW1fdmVy
aWZ5KGpvdXJuYWwsCiAJCQkJCQkJICAgYmgtPmJfZGF0YSkpIHsKK3ByX2luZm8oImRpcmVj
dCBibG9jayB2ZXJpZnkgZXJyb3IuXG4iKTsKIAkJCWNoa3N1bV9lcnJvcjoKK3ByX2luZm8o
ImNoa3N1bV9lcnJvci5cbiIpOwogCQkJCWlmIChjb21taXRfdGltZSA8IGxhc3RfdHJhbnNf
Y29tbWl0X3RpbWUpCiAJCQkJCWdvdG8gaWdub3JlX2NyY19taXNtYXRjaDsKK3ByX2luZm8o
ImVycm9yIGxpbmUgMi5cbiIpOwogCQkJCWluZm8tPmVuZF90cmFuc2FjdGlvbiA9IG5leHRf
Y29tbWl0X0lEOwogCiAJCQkJaWYgKCFqYmQyX2hhc19mZWF0dXJlX2FzeW5jX2NvbW1pdChq
b3VybmFsKSkgeworcHJfaW5mbygiZXJyb3IgbGluZSAzLlxuIik7CiAJCQkJCWpvdXJuYWwt
PmpfZmFpbGVkX2NvbW1pdCA9CiAJCQkJCQluZXh0X2NvbW1pdF9JRDsKIAkJCQkJYnJlbHNl
KGJoKTsKIAkJCQkJYnJlYWs7CiAJCQkJfQorcHJfaW5mbygiZXJyb3IgbGluZSA0LlxuIik7
CiAJCQl9CiAJCQlpZiAocGFzcyA9PSBQQVNTX1NDQU4pCiAJCQkJbGFzdF90cmFuc19jb21t
aXRfdGltZSA9IGNvbW1pdF90aW1lOwogCQkJYnJlbHNlKGJoKTsKIAkJCW5leHRfY29tbWl0
X0lEKys7Citwcl9pbmZvKCJuZXh0X2NvbW1pdF9pZCBpbmNyZWFzZWQ6ICV1LlxuIiwgKHVu
c2lnbmVkIGludCkgbmV4dF9jb21taXRfSUQpOwogCQkJY29udGludWU7CiAKIAkJY2FzZSBK
QkQyX1JFVk9LRV9CTE9DSzoKQEAgLTg1OSwxMCArODcwLDEyIEBAIHN0YXRpYyBpbnQgZG9f
b25lX3Bhc3Moam91cm5hbF90ICpqb3VybmFsLAogCSAqIGxvZy4gIElmIHRoZSBsYXR0ZXIg
aGFwcGVuZWQsIHRoZW4gd2Uga25vdyB0aGF0IHRoZSAiY3VycmVudCIKIAkgKiB0cmFuc2Fj
dGlvbiBtYXJrcyB0aGUgZW5kIG9mIHRoZSB2YWxpZCBsb2cuCiAJICovCitwcl9pbmZvKCJk
b25lLCBpbmZvLT5lbmRfdHJhbnNhY3Rpb24gaXMgJWxkLlxuIiwgKGxvbmcpaW5mby0+ZW5k
X3RyYW5zYWN0aW9uKTsKIAogCWlmIChwYXNzID09IFBBU1NfU0NBTikgewogCQlpZiAoIWlu
Zm8tPmVuZF90cmFuc2FjdGlvbikKIAkJCWluZm8tPmVuZF90cmFuc2FjdGlvbiA9IG5leHRf
Y29tbWl0X0lEOworcHJfaW5mbygiZG9uZSB3aXRoIHVwZGF0ZSwgaW5mby0+ZW5kX3RyYW5z
YWN0aW9uIGlzICVsZC5cbiIsIChsb25nKWluZm8tPmVuZF90cmFuc2FjdGlvbik7CiAJfSBl
bHNlIHsKIAkJLyogSXQncyByZWFsbHkgYmFkIG5ld3MgaWYgZGlmZmVyZW50IHBhc3NlcyBl
bmQgdXAgYXQKIAkJICogZGlmZmVyZW50IHBsYWNlcyAoYnV0IHBvc3NpYmxlIGR1ZSB0byBJ
TyBlcnJvcnMpLiAqLwotLSAKMi4zMy4xCgo=
--------------5Nd0X35ghXa25IVWqhqYY2wi--

