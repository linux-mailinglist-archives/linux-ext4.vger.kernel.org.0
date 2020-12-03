Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4842CD965
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgLCOjE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:39:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33740 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726671AbgLCOjD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:39:03 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3EcDe0002833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:38:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17F66420136; Thu,  3 Dec 2020 09:38:13 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:38:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 1/8] ext4: use ext4_assert() to replace J_ASSERT()
Message-ID: <20201203143813.GJ441757@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 07, 2020 at 11:58:11PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> There are currently multiple forms of assertion, such as J_ASSERT().
> J_ASEERT() is provided for the jbd module, which is a public module.
> Maybe we should use custom ASSERT() like other file systems, such as
> xfs, which would be better.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied --- but I changed ext4_assert() to ASSERT().  All caps
makes it easier to spot the assertion, and since ext4.h is a private
header file, there's no reason to use a "ext4_" or "EXT4_" prefix.

       	     	     	       	  - Ted
