Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559736D0F5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGRPWB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 11:22:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44781 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbfGRPWB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 11:22:01 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6IFLvkT029930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 11:21:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6CADB420054; Thu, 18 Jul 2019 11:21:57 -0400 (EDT)
Date:   Thu, 18 Jul 2019 11:21:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.45.3
Message-ID: <20190718152157.GA25476@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.45.3 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.3

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.45.3.tar.gz

The release notes for 1.45.3 can be found below.

Cheers,

                                        - Ted



E2fsprogs 1.45.3 (July 14, 2019)
================================

Updates/Fixes since v1.45.2:

UI and Features
---------------

Whether or not automatic online scrubs will be run is now controlled by
a setting in /etc/e2scrub.conf.  To enable automatic online scrubs,
uncomment out the line containing "periodic_e2scrub=1".

The fuse2fs program is now installed in /usr/bin instead of /usr/sbin,
since it does not require root privileges.

Fuse2fs now works with if fusermount from FUSE V3 is installed.
However, in order to provide this compatibility, if you are using a
fusermount from FUSE v2, and you want to mount on top of a non-empty
directory, you will need to specify -o nonempty explicitly.  FUSE V3
always allows mounting on top of non-empty directories, and will fail if
the user or fuse2fs passes the nonempty option.


Fixes
-----

Fixed a bug which caused e2fsck to improperly handle file systems that
enabled both the large_dir and inline directories at the same time.

E2scrub_all now correctly handles an encrypted (LUKS) ext[234] file
system stacked on top of an LVM volume.  (Addresses Debian Bug: #931387)

Fixed a bug in "E2scrub_all -r" where it was incorrectly specifying
which volume needed to have its e2scrub snapshot cleaned up.  (Addresses
Debian Bug: #931679)

Fixed the Czech, Dutch, German, and Vietnamese translations which
improperly used positional markers which broke a few translated e2fsck
problem descriptions.  (Addresses Debian Bug: #892173)


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Fixed various debian packaging issues.  (Addresses Debian Bug: #931266,
#923372)

Fixed error checking for calls to posix_{memalign,fadvise}.

Add regression test for checking a file system using fs-verity.

Various regression test cleanups.

Fixed various compiler warnings.

Added xgettext markers to fix incorrectly marked strings in the
e2fsprogs translations template file as being c-style printf strings
when in fact they aren't.

Added utility script which generates the release tarfile using git
archive.

Update the Czech, Dutch, and Portuguese translations from the
Translation Project.

