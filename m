Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B612DBFD
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 23:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLaWHa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 17:07:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41398 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbfLaWHa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Dec 2019 17:07:30 -0500
Received: from callcc.thunk.org ([12.90.237.218])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBVM7OaV001383
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:07:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17F2F420485; Tue, 31 Dec 2019 17:07:24 -0500 (EST)
Date:   Tue, 31 Dec 2019 17:07:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Inconsistent use of string/non_strings in mmp_struct
Message-ID: <20191231220724.GA118765@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

While clearing some compiler in e2fsprogs, I noticed that we are a bit
inconsistent about the mmp_nodename and mmp_bdevname fields, and
whether they are guaranteed to be null terminated or not.  The kernel
is using them in some printf contexts where it's assumed they are null
terminated; but in other places, we have been filling them such that
if the string is exactly 64 or 32 bytes, they will *not* necessarily
be null terminated.

This is potentially a problem both in the kernel as well as in
e2fsprogs.  I propose that we solve this problem by assuming that they
*are* null terminated.  But that means that if there are node names
which are exactly 64 bytes long, or block device names which are
exactly 32 bytes long, badness could happen.

On the other hand, we kind of have this problem already, since in the
kernel, we are using memcmp when comparing mmp_nodename, but in
e2fsprogs userspace, we are using gethostbyname and there is no
guarantee that bytes beyond the terminating NULL have been cleared.
As a result I'm not sure the interlock between e2fsprogs and the
kernel works in all cases anyway.

Or we could go the other way, and try to fix all of the locations
which are accessing and writing mmp_nodename and mmp_bdevname so that
they are considered non-strings which are NULL padded.

Andreas, do you have any preferences here?

						- Ted



