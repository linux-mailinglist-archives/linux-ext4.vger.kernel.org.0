Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AA174A2B
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 00:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgB2Xf2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 18:35:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58602 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727205AbgB2Xf2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 18:35:28 -0500
Received: from callcc.thunk.org (205.220.128.199.nw.nuvox.net [205.220.128.199])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TNZDGx006338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 18:35:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 32DD542045B; Sat, 29 Feb 2020 18:35:13 -0500 (EST)
Date:   Sat, 29 Feb 2020 18:35:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 7/9] e2fsck: fix overflow if more than 4B inodes
Message-ID: <20200229233513.GG38945@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-7-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-7-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:44PM -0700, Andreas Dilger wrote:
> Even though we don't have support for filesystems with over 4B inodes
> in the current e2fsprogs, this may happen in the future.  There are
> latent overflow bugs when calculating the number of inodes in the
> filesystem that can trivially be fixed now, rather than waiting for
> them to be hit at some point in the future.  The block number calcs
> are already correct in this code.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

						- Ted
