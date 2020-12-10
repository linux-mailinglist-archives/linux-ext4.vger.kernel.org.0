Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF12D520F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgLJDvS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 22:51:18 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:52779 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgLJDuo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 22:50:44 -0500
Received: by mail-il1-f199.google.com with SMTP id h4so3231468ilq.19
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 19:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0cTgBqiGrBDRYHQY4vsFsGVcfdNZ3CTtIGa2AjXRHQM=;
        b=E/ux2ucLTTNOY0Sus7ZdPIrCEC6sAqsn+HNmNiRtCX2dqfrTud1Ht1JnBzqbfBkGD+
         1D+FyDbDvFgIi+fjq/OgZfuX/saI8GvTHDQOTy6CPtTAm1Inw3UO0Q/it+BWin50xQ5Z
         i522GmZC7sz9IEh0IRvU6cGRtr4V3QNKfsK69zmLENdhydY1S0e0EP6hV1DH9esa/gSj
         hBf5zILmDxMHPGf9fYp54tBc1+Tv+EJ4GZrpbOj7ihln3YJiz45TL6IrBrekwNmvRawi
         NoLeMltwDWO0GIWdc9ZxYjN6aNHfjyMT9MZcwYYnWO8IDXdPLRsZ+u4xx93XrThevk6s
         Xvow==
X-Gm-Message-State: AOAM531DatLd/2Sug6N/pCkmWrUJ3Jqmb05NKPvq0RnN1JN84OYxJYRl
        srPXWQ2UFmTI0sNcBmQltwK3t/Y6FrJszWTzFKZ68KB08cc3
X-Google-Smtp-Source: ABdhPJyJBi3l4F5GkR7QE/LAQNz6qZ3uFv+qO5865YwPpiuNkNUCxXJdCxiFDp6XnB01MVcNXgIHtBtdJa2j8DlZclJ7cXZ20a6x
MIME-Version: 1.0
X-Received: by 2002:a05:6638:e8c:: with SMTP id p12mr7286833jas.112.1607572203501;
 Wed, 09 Dec 2020 19:50:03 -0800 (PST)
Date:   Wed, 09 Dec 2020 19:50:03 -0800
In-Reply-To: <20201210023638.GP52960@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024030c05b61412e6@google.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
From:   syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git on commit e360ba58d067a30a4e3e7d55ebdd919885a058d6: failed to run ["git" "fetch" "--tags" "d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8"]: exit status 1
From git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
 * [new branch]                bisect-test-ext4-035     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-ext4-035
 * [new branch]                bisect-test-generic-307  -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-generic-307
 * [new branch]                dev                      -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/dev
 * [new branch]                ext4-3.18                -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-3.18
 * [new branch]                ext4-4.1                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.1
 * [new branch]                ext4-4.4                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.4
 * [new branch]                ext4-4.9                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.9
 * [new branch]                ext4-dax                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-dax
 * [new branch]                ext4-tools               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-tools
 * [new branch]                fix-bz-206443            -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fix-bz-206443
 * [new branch]                for-stable               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/for-stable
 * [new branch]                fsverity                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fsverity
 * [new branch]                lazy_journal             -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/lazy_journal
 * [new branch]                master                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/master
 * [new branch]                origin                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/origin
 * [new branch]                pu                       -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/pu
 * [new branch]                test                     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/test
 * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
 ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)
 * [new tag]                   ext4_for_linus_bugfixes  -> ext4_for_linus_bugfixes
 * [new tag]                   ext4_for_linus_cleanups  -> ext4_for_linus_cleanups
 * [new tag]                   ext4_for_linus_fixes     -> ext4_for_linus_fixes
 * [new tag]                   ext4_for_linus_fixes2    -> ext4_for_linus_fixes2



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git e360ba58d067a30a4e3e7d55ebdd919885a058d6
dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1499c287500000

