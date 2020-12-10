Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F252D5C90
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbgLJN6H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 08:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgLJN5v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 08:57:51 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D737C0613D6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 05:57:11 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id p12so2361353qvj.13
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyrMMU0omj6NS8PnhNAq4zKjR5kYFuT9HRGwfp3GnV0=;
        b=ULeEqyb056eyx8EiootK7RvHCnxkIU9jq28VFsRh/sxEfXUNy0zQKilqwunnEg6A0w
         67vLdEwQVVlFRVdfzc3nDO5m3MI9roIHwkmE8rmUUjSwEYhLy95JLC/GnpSsT47lAgru
         YqRzsBl6MCj8rD93nXeHISMBcFzUu5TRIeFhKKimC3fA6wYgHywopPCOPBvbBHki/UYz
         dWq+rFFCDVaPK/80+IMmfPis8SHwUVQ0piMf1Wp5dyTC6YhD5G8uWygyxEVvUKst4sKo
         66aK6Lf/Ba3gkcbq7f58478FiJ+HAbLCjfiszYyZi9croU9h72fIrGrB5tgqlJrj2NJi
         Yhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyrMMU0omj6NS8PnhNAq4zKjR5kYFuT9HRGwfp3GnV0=;
        b=Zt9DFqkiUzNGdOLlrD7iOS7f7f78yL9C9l3RjejQ4AHAiJ3O6BD0IjgNgOK+Rr6UO3
         NWU0mSfbMk/T1ICeWHY5HqToDIk+8NV3bMHpEoemIAtTdE7urcGe6cJwyXmYPhMFxnpe
         V1R4tZaLSHiodQsvbamI5oVpsqXYINAnxBNHLzWrKDohIwMfVYw7Sv3x3OKqVFr8Gj39
         qrL8Z7ywfLvHt5NUPkVYla1Q7yJlhycj+Jwn6j8jthfsvQK9MFvVpXtujAQpvXaTmqj3
         5ihlixeJBorFf8nwWWqAB/zXLhN4tnzdcSItpjBWPQTQCT5/NS9xaJ3ZjcDuWchAdhX6
         iHAw==
X-Gm-Message-State: AOAM532y1QHWtV+oyxzSTpDfA9HjC72HzE4w2xIpgsuWRnH5c3n0Rots
        TL9BbSkhCXOALpzmQC0odIKkGQ3n/3mb9neuDjsdsItfgMou99qq
X-Google-Smtp-Source: ABdhPJy9MpIaNivKN4A0rekYPQ+E7wYjFJcXc6cZ81XnIBiWFZhqXPzZp3NzpSJBLeHNLXwKZPDeef4OvcRn0oPHab4=
X-Received: by 2002:a0c:d80e:: with SMTP id h14mr9359940qvj.13.1607608630272;
 Thu, 10 Dec 2020 05:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20201210023638.GP52960@mit.edu> <00000000000024030c05b61412e6@google.com>
 <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Dec 2020 14:56:58 +0100
Message-ID: <CACT4Y+a+ZwwEup7xgfsJth-=T-o-tYNHpVc0m4ePx0fj9LBHZw@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
To:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: multipart/mixed; boundary="0000000000005903b905b61c8d61"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000005903b905b61c8d61
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 10, 2020 at 9:09 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Dec 10, 2020 at 4:50 AM syzbot
> <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot tried to test the proposed patch but the build/boot failed:
> >
> > failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git on commit e360ba58d067a30a4e3e7d55ebdd919885a058d6: failed to run ["git" "fetch" "--tags" "d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8"]: exit status 1
> > From git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> >  * [new branch]                bisect-test-ext4-035     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-ext4-035
> >  * [new branch]                bisect-test-generic-307  -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-generic-307
> >  * [new branch]                dev                      -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/dev
> >  * [new branch]                ext4-3.18                -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-3.18
> >  * [new branch]                ext4-4.1                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.1
> >  * [new branch]                ext4-4.4                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.4
> >  * [new branch]                ext4-4.9                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.9
> >  * [new branch]                ext4-dax                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-dax
> >  * [new branch]                ext4-tools               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-tools
> >  * [new branch]                fix-bz-206443            -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fix-bz-206443
> >  * [new branch]                for-stable               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/for-stable
> >  * [new branch]                fsverity                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fsverity
> >  * [new branch]                lazy_journal             -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/lazy_journal
> >  * [new branch]                master                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/master
> >  * [new branch]                origin                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/origin
> >  * [new branch]                pu                       -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/pu
> >  * [new branch]                test                     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/test
> >  * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
> >  ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)
>
> Interesting. First time I see this. Should syzkaller use 'git fetch
> --tags --force"?...
> StackOverflow suggests it should help:
> https://stackoverflow.com/questions/58031165/how-to-get-rid-of-would-clobber-existing-tag


I've added --force to fetches:
https://github.com/google/syzkaller/commit/9a72bc3440b65a01187ba4277b49d6bd821079cd
 and it should be deployed by now. Let's try again:

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
e360ba58d067a30a4e3e7d55ebdd919885a058d6

--0000000000005903b905b61c8d61
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kiiwnrjf0>
X-Attachment-Id: f_kiiwnrjf0

RnJvbSAzZDNiYzMwM2E4YThmNzEyM2NmNDg2ZjQ5ZmE5MDYwMTE2ZmExNDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1PgpEYXRlOiBX
ZWQsIDkgRGVjIDIwMjAgMTU6NTk6MTEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBleHQ0OiBjaGVj
ayBmb3IgaW52YWxpZCBibG9jayBzaXplIGVhcmx5IHdoZW4gbW91bnRpbmcgYSBmaWxlCiBzeXN0
ZW0KCkNoZWNrIGZvciB2YWxpZCBibG9jayBzaXplIGRpcmVjdGx5IGJ5IHZhbGlkYXRpbmcgc19s
b2dfYmxvY2tfc2l6ZTsgd2UKd2VyZSBkb2luZyB0aGlzIGluIHR3byBwbGFjZXMuICBGaXJzdCwg
YnkgY2FsY3VsYXRpbmcgYmxvY2tzaXplIHZpYQpCTE9DS19TSVpFIDw8IHNfbG9nX2Jsb2NrX3Np
emUsIGFuZCB0aGVuIGNoZWNraW5nIHRoYXQgdGhlIGJsb2Nrc2l6ZQp3YXMgdmFsaWQuICBBbmQg
dGhlbiBzZWNvbmRseSwgYnkgY2hlY2tpbmcgc19sb2dfYmxvY2tfc2l6ZSBkaXJlY3RseS4KClRo
ZSBmaXJzdCBjaGVjayBpcyBub3QgcmVsaWFibGUsIGFuZCBjYW4gdHJpZ2dlciBhbiBVQlNBTiB3
YXJuaW5nIGlmCnNfbG9nX2Jsb2NrX3NpemUgb24gYSBtYWxpY2lvdXNseSBjb3JydXB0ZWQgc3Vw
ZXJibG9jayBpcyBncmVhdGVyIHRoYW4KMjIuICBUaGlzIGlzIGhhcm1sZXNzLCBzaW5jZSB0aGUg
c2Vjb25kIHRlc3Qgd2lsbCBjb3JyZWN0bHkgcmVqZWN0IHRoZQptYWxpY2lvdXNseSBmdXp6ZWQg
ZmlsZSBzeXN0ZW0sIGJ1dCB0byBtYWtlIHN5emJvdCBzaHV0IHVwLCBhbmQKYmVjYXVzZSB0aGUg
dHdvIGNoZWNrcyBhcmUgZHVwbGljYXRpdmUgaW4gYW55IGNhc2UsIGRlbGV0ZSB0aGUKYmxvY2tz
aXplIGNoZWNrLCBhbmQgbW92ZSB0aGUgc19sb2dfYmxvY2tfc2l6ZSBlYXJsaWVyIGluCmV4dDRf
ZmlsbF9zdXBlcigpLgoKU2lnbmVkLW9mZi1ieTogVGhlb2RvcmUgVHMnbyA8dHl0c29AbWl0LmVk
dT4KUmVwb3J0ZWQtYnk6IHN5emJvdCszNDViNzU2NTJiMWQyNDIyNzQ0M0BzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tCi0tLQogZnMvZXh0NC9zdXBlci5jIHwgNDAgKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyks
IDI0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQvc3VwZXIuYyBiL2ZzL2V4dDQv
c3VwZXIuYwppbmRleCBmODYyMjBhOGRmNTAuLjRhMTZiYmYwNDMyYyAxMDA2NDQKLS0tIGEvZnMv
ZXh0NC9zdXBlci5jCisrKyBiL2ZzL2V4dDQvc3VwZXIuYwpAQCAtNDIwMiwxOCArNDIwMiwyNSBA
QCBzdGF0aWMgaW50IGV4dDRfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB2b2lk
ICpkYXRhLCBpbnQgc2lsZW50KQogCSAqLwogCXNiaS0+c19saV93YWl0X211bHQgPSBFWFQ0X0RF
Rl9MSV9XQUlUX01VTFQ7CiAKLQlibG9ja3NpemUgPSBCTE9DS19TSVpFIDw8IGxlMzJfdG9fY3B1
KGVzLT5zX2xvZ19ibG9ja19zaXplKTsKLQotCWlmIChibG9ja3NpemUgPT0gUEFHRV9TSVpFKQot
CQlzZXRfb3B0KHNiLCBESU9SRUFEX05PTE9DSyk7Ci0KLQlpZiAoYmxvY2tzaXplIDwgRVhUNF9N
SU5fQkxPQ0tfU0laRSB8fAotCSAgICBibG9ja3NpemUgPiBFWFQ0X01BWF9CTE9DS19TSVpFKSB7
CisJaWYgKGxlMzJfdG9fY3B1KGVzLT5zX2xvZ19ibG9ja19zaXplKSA+CisJICAgIChFWFQ0X01B
WF9CTE9DS19MT0dfU0laRSAtIEVYVDRfTUlOX0JMT0NLX0xPR19TSVpFKSkgewogCQlleHQ0X21z
ZyhzYiwgS0VSTl9FUlIsCi0JCSAgICAgICAiVW5zdXBwb3J0ZWQgZmlsZXN5c3RlbSBibG9ja3Np
emUgJWQgKCVkIGxvZ19ibG9ja19zaXplKSIsCi0JCQkgYmxvY2tzaXplLCBsZTMyX3RvX2NwdShl
cy0+c19sb2dfYmxvY2tfc2l6ZSkpOworCQkJICJJbnZhbGlkIGxvZyBibG9jayBzaXplOiAldSIs
CisJCQkgbGUzMl90b19jcHUoZXMtPnNfbG9nX2Jsb2NrX3NpemUpKTsKIAkJZ290byBmYWlsZWRf
bW91bnQ7CiAJfQorCWlmIChsZTMyX3RvX2NwdShlcy0+c19sb2dfY2x1c3Rlcl9zaXplKSA+CisJ
ICAgIChFWFQ0X01BWF9DTFVTVEVSX0xPR19TSVpFIC0gRVhUNF9NSU5fQkxPQ0tfTE9HX1NJWkUp
KSB7CisJCWV4dDRfbXNnKHNiLCBLRVJOX0VSUiwKKwkJCSAiSW52YWxpZCBsb2cgY2x1c3RlciBz
aXplOiAldSIsCisJCQkgbGUzMl90b19jcHUoZXMtPnNfbG9nX2NsdXN0ZXJfc2l6ZSkpOworCQln
b3RvIGZhaWxlZF9tb3VudDsKKwl9CisKKwlibG9ja3NpemUgPSBFWFQ0X01JTl9CTE9DS19TSVpF
IDw8IGxlMzJfdG9fY3B1KGVzLT5zX2xvZ19ibG9ja19zaXplKTsKKworCWlmIChibG9ja3NpemUg
PT0gUEFHRV9TSVpFKQorCQlzZXRfb3B0KHNiLCBESU9SRUFEX05PTE9DSyk7CiAKIAlpZiAobGUz
Ml90b19jcHUoZXMtPnNfcmV2X2xldmVsKSA9PSBFWFQ0X0dPT0RfT0xEX1JFVikgewogCQlzYmkt
PnNfaW5vZGVfc2l6ZSA9IEVYVDRfR09PRF9PTERfSU5PREVfU0laRTsKQEAgLTQ0MzIsMjEgKzQ0
MzksNiBAQCBzdGF0aWMgaW50IGV4dDRfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCB2b2lkICpkYXRhLCBpbnQgc2lsZW50KQogCWlmICghZXh0NF9mZWF0dXJlX3NldF9vayhzYiwg
KHNiX3Jkb25seShzYikpKSkKIAkJZ290byBmYWlsZWRfbW91bnQ7CiAKLQlpZiAobGUzMl90b19j
cHUoZXMtPnNfbG9nX2Jsb2NrX3NpemUpID4KLQkgICAgKEVYVDRfTUFYX0JMT0NLX0xPR19TSVpF
IC0gRVhUNF9NSU5fQkxPQ0tfTE9HX1NJWkUpKSB7Ci0JCWV4dDRfbXNnKHNiLCBLRVJOX0VSUiwK
LQkJCSAiSW52YWxpZCBsb2cgYmxvY2sgc2l6ZTogJXUiLAotCQkJIGxlMzJfdG9fY3B1KGVzLT5z
X2xvZ19ibG9ja19zaXplKSk7Ci0JCWdvdG8gZmFpbGVkX21vdW50OwotCX0KLQlpZiAobGUzMl90
b19jcHUoZXMtPnNfbG9nX2NsdXN0ZXJfc2l6ZSkgPgotCSAgICAoRVhUNF9NQVhfQ0xVU1RFUl9M
T0dfU0laRSAtIEVYVDRfTUlOX0JMT0NLX0xPR19TSVpFKSkgewotCQlleHQ0X21zZyhzYiwgS0VS
Tl9FUlIsCi0JCQkgIkludmFsaWQgbG9nIGNsdXN0ZXIgc2l6ZTogJXUiLAotCQkJIGxlMzJfdG9f
Y3B1KGVzLT5zX2xvZ19jbHVzdGVyX3NpemUpKTsKLQkJZ290byBmYWlsZWRfbW91bnQ7Ci0JfQot
CiAJaWYgKGxlMTZfdG9fY3B1KHNiaS0+c19lcy0+c19yZXNlcnZlZF9nZHRfYmxvY2tzKSA+IChi
bG9ja3NpemUgLyA0KSkgewogCQlleHQ0X21zZyhzYiwgS0VSTl9FUlIsCiAJCQkgIk51bWJlciBv
ZiByZXNlcnZlZCBHRFQgYmxvY2tzIGluc2FuZWx5IGxhcmdlOiAlZCIsCg==
--0000000000005903b905b61c8d61--
