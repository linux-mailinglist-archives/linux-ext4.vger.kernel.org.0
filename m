Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92712AA25C
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgKGDxV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 22:53:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42423 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727142AbgKGDxV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 22:53:21 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A73qDAU010914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Nov 2020 22:52:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C07F420107; Fri,  6 Nov 2020 22:52:13 -0500 (EST)
Date:   Fri, 6 Nov 2020 22:52:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: report error message when setting usrjquota or
 grpjquota options failed
Message-ID: <20201107035213.GC2499342@mit.edu>
References: <1603986396-28917-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603986396-28917-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 29, 2020 at 11:46:36PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The macro MOPT_Q is used to indicates the mount option is quota stuff and
> would be the same as MOPT_NOSUPPORT when CONFIG_QUOTA is disabled. We want
> to report NOSUPPORT error message when setting usrjquota or grpjquota
> options with the CONFIG_QUOTA is disabled, but now it report nothing. So
> fix it by adding the MOPT_STRING flag.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Thanks, applied with an improved commit description:

    The macro MOPT_Q is used to indicates the mount option is related
    to quota stuff and is defined to be MOPT_NOSUPPORT when
    CONFIG_QUOTA is disabled.  Normally the quota options are handled
    explicitly, so it didn't matter that the MOPT_STRING flag was
    missing, even though the usrjquota and grpjquota mount options
    take a string argument.  It's important that's present in the
    !CONFIG_QUOTA case, since without MOPT_STRING, the mount option
    matcher will match usrjquota= followed by an integer, and will
    otherwise skip the table entry, and so "mount option not
    supported" error message is never reported.

					- Ted
