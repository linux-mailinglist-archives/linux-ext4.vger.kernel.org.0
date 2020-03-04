Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA151179C6F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgCDX1S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Mar 2020 18:27:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37987 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388425AbgCDX1S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Mar 2020 18:27:18 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024NRC6M012906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 18:27:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5639242045B; Wed,  4 Mar 2020 18:27:12 -0500 (EST)
Date:   Wed, 4 Mar 2020 18:27:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 9/9] misc: handle very large files with filefrag
Message-ID: <20200304232712.GH74069@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581037786-62789-9-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-9-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:46PM -0700, Andreas Dilger wrote:
> Avoid overflowing the column-width calc printing files over 4B blocks.
> 
> Document the [KMG] suffixes for the "-b <blocksize>" option.
> 
> The blocksize is limited to at most 1GiB blocksize to avoid shifting
> all extents down to zero GB in size.  Even the use of 1GB blocksize
> is unlikely, but non-ext4 filesystems may use multi-GB extents.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

				- Ted
