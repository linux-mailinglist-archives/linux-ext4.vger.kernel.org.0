Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A135346C3BC
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Dec 2021 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhLGThs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Dec 2021 14:37:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59902 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231629AbhLGThs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Dec 2021 14:37:48 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B7JY8tq028704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Dec 2021 14:34:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7BFAA4205DB; Tue,  7 Dec 2021 14:34:07 -0500 (EST)
Date:   Tue, 7 Dec 2021 14:34:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, wshilong@ddn.com,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Message-ID: <Ya+3L3gBFCeWZki7@mit.edu>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
> > Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
> > removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
> > ext4_statfs() output incorrect (function does not apply quota limits
> > on used/available space, etc) when called on dentry of regular file
> > with project quota enabled.

Under what circumstance is userspace trying to call statfs on a file
descriptor?

Removing the test for EXT4_INODE_PROJINHERIT will cause
incorrect/misleading results being returned in the case where we have
a directory where a directory hierarchy is using project id's, but
which is *not* using PROJINHERIT.

				- Ted
