Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497473E0C7A
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 04:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhHECfs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 22:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhHECfp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 22:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628130931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=CMK629/i8rlV/usgjzjv12E8h3L65L9c1FAVGf4uOxs=;
        b=UgMNF7ilIc0ValQixVBO6rfEsqD2+LeybNG+I9Rg4FgmzycGtzhD+SkWNOjnC0hQdrxJLk
        BrPbyn2URQXKmSN+BuwQVLQVvSeZBIAJZW/H5cUhwcHIlcirdYEYcGX424ezo3IVCBFfjG
        TkuYveHdZiWJb/SFXcmw7zfyGq8S9pg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-1FPIUdMfNI6caA7_5CU_aQ-1; Wed, 04 Aug 2021 22:35:29 -0400
X-MC-Unique: 1FPIUdMfNI6caA7_5CU_aQ-1
Received: by mail-pj1-f71.google.com with SMTP id q6-20020a17090aa006b02901779796d79eso6135954pjp.1
        for <linux-ext4@vger.kernel.org>; Wed, 04 Aug 2021 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CMK629/i8rlV/usgjzjv12E8h3L65L9c1FAVGf4uOxs=;
        b=MFJAxKNmeFdpkU2w7h1nhBqE8QCKBkD7aVNPPZLH3UhknSR52/9vyh4sKIH7KabzOI
         M+2SF1tUHyd4pPokG+mYpIjXxbOaMNfCJ6aTh7VtPLyN3roKLqRYn80nbbXRCkuHbx+Y
         WxcGSghKIxiA90rrcE5LJ+VJhWpgYXGyiR5X3/+xFNCZXSo2yJE1hbEgrLc3Sjtr2NmG
         cLnhKv+T+Vp5SGsLoZNttENGPJS2EuPxFNrLiz6CMxabWC2yN8xQI+s4XKWcX9QHnooA
         0urHEBmrIQJeuMP8LtHZtllCrb4wlXcVWDFVINT2wxnjLxO52cFAmrTzXGGHoSnfDT91
         EL0Q==
X-Gm-Message-State: AOAM530YpHpiJrVsBzA7I672H13tcIg6o6JWNWQ05lg5e0TuF/6Sgknh
        QR8KvWG+VZ4/0IJv4qG4do2oqMrenugVXaFgMv64CJotSxPmY7zHPQZw0oL7mnpzJb4NrV83nY1
        6QbHBxbINGteXcNRtqyozYTgP2brX+KEudu9y8A==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr12975653pjb.178.1628130928292;
        Wed, 04 Aug 2021 19:35:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3KWlAIyA1Z9oQT3W1CA0dKRVlzLaZozlv6ZY6MYMXEztnHneJZnYegD2D+hePzrfZjFTP+kaITvqNfWgRMQ=
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr12975632pjb.178.1628130927983;
 Wed, 04 Aug 2021 19:35:27 -0700 (PDT)
MIME-Version: 1.0
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 5 Aug 2021 10:35:16 +0800
Message-ID: <CAHLe9YbqejLQJO-6-a0ETtNUitQtsYr3Q2b7xW4VV=6fXO6APw@mail.gmail.com>
Subject: [kernel-5.11 regression] tune2fs fails after shutdown
To:     linux-ext4@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009c776a05c8c6c570"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000009c776a05c8c6c570
Content-Type: text/plain; charset="UTF-8"

Hi,

kernel commit

4274f516d4bc ext4: recalucate superblock checksum after updating free
blocks/inodes

had been reverted by

81414b4dd48 ext4: remove redundant sb checksum recomputation

since kernel-5.11-rc1. As a result, the original reproducer fails again.

Reproducer:
```
mkdir mntpt
fallocate -l 256M mntpt.img
mkfs.ext4 -Fq -t ext4 mntpt.img 128M
LPDEV=$(losetup -f --show mntpt.img)
mount "$LPDEV" mntpt
cp /proc/version mntpt/
./godown mntpt # godown program attached.
umount mntpt
mount "$LPDEV" mntpt
tune2fs -l "$LPDEV"
```

tune2fs fails with
```
tune2fs 1.46.2 (28-Feb-2021)
tune2fs: Superblock checksum does not match superblock while trying to
open /dev/loop0
Couldn't find valid filesystem superblock.
```

Tested on e2fsprogs-1.46.2 + kernel-5.14.0-0.rc3.29. I think it's a
regression. If this is the case, can we fix it again please?

Thanks,
Boyang

--0000000000009c776a05c8c6c570
Content-Type: application/octet-stream; name="godown.c"
Content-Disposition: attachment; filename="godown.c"
Content-Transfer-Encoding: base64
Content-ID: <f_kryazjid0>
X-Attachment-Id: f_kryazjid0

LyoKICogQ29weSB0aGlzIHByb2dyYW0gZnJvbSB4ZnN0ZXN0cy9zcmMvZ29kb3duLmMKICogY2hh
bmdlIHNvbWUgY29kZSB0byBtYWtlIHN1cmUgdGhpcyBwcm9ncmFtIGNhbgogKiBiZSBjb21waWxl
ZCBpbmRpdmlkdWFsbHksIGRvbid0IG5lZWQgdG8gY29tcGlsZQogKiB3aXRoIGFsbCB4ZnN0ZXN0
cyBwcm9ncmFtLiAKICogKHN0aWxsIGRlcGVuZHMgb24geGZzcHJvZ3MtZGV2ZWwgb2YgY291cnNl
KQogKgogKiBnY2MgLW8gZ29kb3duIGdvZG93bi5jIC1XYWxsCiAqCiAqIE1vZGlmaWVkIGJ5OiBa
b3JybyBMYW5nIDx6bGFuZ0ByZWRoYXQuY29tPgogKgogKi8KCiNkZWZpbmUgX0dOVV9TT1VSQ0UK
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXNsb2cuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8Z2V0b3B0
Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRl
IDxzeXMvc3RhdHZmcy5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHhmcy94ZnMuaD4K
CnN0YXRpYyBjaGFyICp4cHJvZ25hbWU7CgoKc3RhdGljIHZvaWQKdXNhZ2Uodm9pZCkKewoJZnBy
aW50ZihzdGRlcnIsICJ1c2FnZTogJXMgWy1mXSBbLXZdIG1udC1kaXJcbiIsIHhwcm9nbmFtZSk7
Cn0KCmludAptYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWludCBjOwoJaW50IGZsYWc7
CglpbnQgZmx1c2hsb2dfb3B0ID0gMDsKCWludCB2ZXJib3NlX29wdCA9IDA7CglzdHJ1Y3Qgc3Rh
dCBzdDsKCWNoYXIgKm1udF9kaXI7CglpbnQgZmQ7CgogICAgICAJeHByb2duYW1lID0gYXJndlsw
XTsKCgl3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImZ2IikpICE9IC0xKSB7CgkJc3dp
dGNoIChjKSB7CgkJY2FzZSAnZic6CgkJCWZsdXNobG9nX29wdCA9IDE7CgkJCWJyZWFrOwoJCWNh
c2UgJ3YnOgoJCQl2ZXJib3NlX29wdCA9IDE7CgkJCWJyZWFrOwoJCWNhc2UgJz8nOgoJCQl1c2Fn
ZSgpOwoJCQlyZXR1cm4gMTsKCQl9Cgl9CgoJLyogcHJvY2VzcyByZXF1aXJlZCBjbWQgYXJndW1l
bnQgKi8KCWlmIChvcHRpbmQgPT0gYXJnYy0xKSB7CgkJbW50X2RpciA9IGFyZ3Zbb3B0aW5kXTsK
CX0KCWVsc2UgewoJCXVzYWdlKCk7CgkJcmV0dXJuIDE7Cgl9CgoJaWYgKChzdGF0KG1udF9kaXIs
ICZzdCkpID09IC0xKSB7CgkJZnByaW50ZihzdGRlcnIsICIlczogZXJyb3Igb24gc3RhdCBcIiVz
XCI6ICVzXG4iLAoJCQl4cHJvZ25hbWUsIG1udF9kaXIsIHN0cmVycm9yKGVycm5vKSk7CgkJcmV0
dXJuIDE7Cgl9CgoJaWYgKCFTX0lTRElSKHN0LnN0X21vZGUpKSB7CgkJZnByaW50ZihzdGRlcnIs
ICIlczogYXJndW1lbnQgXCIlc1wiIGlzIG5vdCBhIGRpcmVjdG9yeVxuIiwKCQkJeHByb2duYW1l
LCBtbnRfZGlyKTsKCQlyZXR1cm4gMTsKCX0KCgkKI2lmIDAKCXsKCQlzdHJ1Y3Qgc3RhdHZmcyBz
dHZmczsKCQlpZiAoKHN0YXR2ZnMobW50X2RpciwgJnN0dmZzKSkgPT0gLTEpIHsKCQkJZnByaW50
ZihzdGRlcnIsICIlczogZXJyb3Igb24gc3RhdGZzIFwiJXNcIjogJXNcbiIsCgkJCQl4cHJvZ25h
bWUsIG1udF9kaXIsIHN0cmVycm9yKGVycm5vKSk7CgkJCXJldHVybiAxOwoJCX0KCgkJaWYgKHN0
cmNtcChzdHZmcy5mX2Jhc2V0eXBlLCAieGZzIikgIT0gMCkgewoJCQlmcHJpbnRmKHN0ZGVyciwg
IiVzOiBmaWxlc3lzIGZvciBcIiVzXCIgaXMgbm90IFhGUzpcIiVzXCJcbiIsCgkJCQl4cHJvZ25h
bWUsIG1udF9kaXIsIHN0dmZzLmZfYmFzZXR5cGUpOwoJCQlyZXR1cm4gMTsKCQl9Cgl9CiNlbmRp
ZgoKCglmbGFnID0gKGZsdXNobG9nX29wdCA/IFhGU19GU09QX0dPSU5HX0ZMQUdTX0xPR0ZMVVNI
IAoJCQkgICAgOiBYRlNfRlNPUF9HT0lOR19GTEFHU19OT0xPR0ZMVVNIKTsKCglpZiAodmVyYm9z
ZV9vcHQpIHsKCQlwcmludGYoIk9wZW5pbmcgXCIlc1wiXG4iLCBtbnRfZGlyKTsKCX0KCWlmICgo
ZmQgPSBvcGVuKG1udF9kaXIsIE9fUkRPTkxZKSkgPT0gLTEpIHsKCQlmcHJpbnRmKHN0ZGVyciwg
IiVzOiBlcnJvciBvbiBvcGVuIG9mIFwiJXNcIjogJXNcbiIsCgkJCXhwcm9nbmFtZSwgbW50X2Rp
ciwgc3RyZXJyb3IoZXJybm8pKTsKCQlyZXR1cm4gMTsKCX0KCglpZiAodmVyYm9zZV9vcHQpIHsK
CQlwcmludGYoIkNhbGxpbmcgWEZTX0lPQ19HT0lOR0RPV05cbiIpOwoJfQoJc3lzbG9nKExPR19X
QVJOSU5HLCAieGZzdGVzdHMtaW5kdWNlZCBmb3JjZWQgc2h1dGRvd24gb2YgJXM6XG4iLAoJCW1u
dF9kaXIpOwoJaWYgKCh4ZnNjdGwobW50X2RpciwgZmQsIFhGU19JT0NfR09JTkdET1dOLCAmZmxh
ZykpID09IC0xKSB7CgkJZnByaW50ZihzdGRlcnIsICIlczogZXJyb3Igb24geGZzY3RsKEdPSU5H
RE9XTikgb2YgXCIlc1wiOiAlc1xuIiwKCQkJeHByb2duYW1lLCBtbnRfZGlyLCBzdHJlcnJvcihl
cnJubykpOwoJCXJldHVybiAxOwoJfQoKCWNsb3NlKGZkKTsKCglyZXR1cm4gMDsKfQo=
--0000000000009c776a05c8c6c570--

