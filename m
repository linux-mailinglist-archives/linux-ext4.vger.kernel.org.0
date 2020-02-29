Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE50174A30
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 00:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgB2XgQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 18:36:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58786 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727205AbgB2XgQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 18:36:16 -0500
Received: from callcc.thunk.org (205.220.128.199.nw.nuvox.net [205.220.128.199])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TNa3b0006478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 18:36:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7415842045B; Sat, 29 Feb 2020 18:36:02 -0500 (EST)
Date:   Sat, 29 Feb 2020 18:36:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 8/9] e2fsck: consistently use ext2fs_get_mem()
Message-ID: <20200229233602.GH38945@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-8-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-8-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:45PM -0700, Andreas Dilger wrote:
> Consistently use ext2fs_get_mem() and ext2fs_free_mem() instead of
> calling malloc() and free() directly in e2fsck.  In several places
> it is possible to use ext2fs_get_memzero() instead of explicitly
> calling memset() on the memory afterward.
> 
> This is just a code cleanup, and does not fix any specific bugs.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

					- Ted
