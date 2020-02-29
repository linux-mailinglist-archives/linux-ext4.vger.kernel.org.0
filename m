Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91B174A1C
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 00:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgB2X2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 18:28:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57212 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbgB2X23 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 18:28:29 -0500
Received: from callcc.thunk.org (205.220.128.199.nw.nuvox.net [205.220.128.199])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TNSIiv004666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 18:28:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7596142045B; Sat, 29 Feb 2020 18:28:17 -0500 (EST)
Date:   Sat, 29 Feb 2020 18:28:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/9] e2fsck: avoid mallinfo() if over 2GB allocated
Message-ID: <20200229232817.GC38945@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-3-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-3-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:40PM -0700, Andreas Dilger wrote:
> Don't use mallinfo() for determining the amount of memory used if it
> is over 2GB.  Otherwise, the signed ints used by this interface can
> can overflow and return garbage values.  This makes the actual amount
> of memory used by e2fsck misleading and hard to determine.
> 
> Instead, use brk() to get the total amount of memory allocated, and print
> this if the more detailed mallinfo() information is not suitable for use.
> 
> There does not appear to be a mallinfo64() variant of this function.
> There does appear to be an abomination named malloc_info() that writes
> XML-formatted malloc stats to a FILE stream that would need to be read
> and parsed in order to get these stats, but that doesn't seem worthwhile.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Reviewed-by: Shilong Wang <wshilong@ddn.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

					- Ted
