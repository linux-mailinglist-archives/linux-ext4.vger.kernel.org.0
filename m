Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF0BBEFA
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 01:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408203AbfIWXbh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Sep 2019 19:31:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59467 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729152AbfIWXbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Sep 2019 19:31:37 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8NNVWdj011827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 19:31:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 821104200BF; Mon, 23 Sep 2019 19:31:32 -0400 (EDT)
Date:   Mon, 23 Sep 2019 19:31:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.45.4
Message-ID: <20190923233132.GB3136@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.45.4 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:
 
http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.4
 
and
 
http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.45.4.tar.gz

The release notes for 1.45.4 can be found below.  Note that if your
system/distribution allows malicious users to trick the system into
running e2fsck on an untrustworthy source as root, you are strongly
recommended to take this release, or cherry pick 8dbe7b475ec5:
"libsupport: add checks to prevent buffer overrun bugs in quota code".

Cheers,

                                        - Ted


E2fsprogs 1.45.4 (September 23, 2019)
=====================================

Updates/Fixes since v1.45.3:

Fixes
-----

A maliciously corrupted file systems can trigger buffer overruns in the
quota code used by e2fsck.  (Addresses CVE-2019-5094)

E2fsck now checks to make sure the casefold flag is only set on
directories, and only when the casefold feature is enabled.

E2fsck will not disable the low dtime checks when using a backup
superblock where the last mount time is zero.  This fixes a failure in
xfstests ext4/007.

Fix e2fsck so that when it needs to recreate the root directory, the
quota counts are correctly updated.

Fix e2scrub_all cron script so it checks to make sure e2scrub_all
exists, since the crontab and cron script might stick around after the
e2fsprogs package is removed.  (Addresses Debian Bug: #932622)

Fix e2scrub_all so that it works when the free space is exactly the
snapshot size.  (Addresses Debian Bug: #935009)

Avoid spurious lvm warnings when e2scrub_all is run out of cron on
non-systemd systems (Addresses Debian Bug: #940240)

Update the man pages to document the new fsverity feature, and improve
the documentation for the casefold and encrypt features.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Fixed various debian packaging issues.  (Addresses Debian Bug: #933247,
#932874, #932876, #932855, #932859, #932861, #932881, #932888)

Fix false positive test failure in f_pre_1970_date_encoding on 32-bit
systems with a 64-bit time_t.  (Addresses Debian Bug: #932906)

Fixed various compiler warnings.  (Addresses Google Bug #118836063)

Update the Czech, Dutch, French, German, Malay, Polish, Portuguese,
Spanish, Swedish, Ukrainian, and Vietnamese translations from the
Translation Project.

