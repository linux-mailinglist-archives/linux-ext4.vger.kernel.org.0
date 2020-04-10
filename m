Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6341A408F
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 05:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgDJDtk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Apr 2020 23:49:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58625 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728600AbgDJDtk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Apr 2020 23:49:40 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03A3nXpv004315
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 23:49:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 96D8B42013D; Thu,  9 Apr 2020 23:49:33 -0400 (EDT)
Date:   Thu, 9 Apr 2020 23:49:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix return-value types in several function
 documentation comments
Message-ID: <20200410034933.GJ45598@mit.edu>
References: <60a3f4996f4932c45515aaa6b75ca42f2a78ec9b.1585512514.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a3f4996f4932c45515aaa6b75ca42f2a78ec9b.1585512514.git.josh@joshtriplett.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 29, 2020 at 01:21:41PM -0700, Josh Triplett wrote:
> The documentation comments for ext4_read_block_bitmap_nowait and
> ext4_read_inode_bitmap describe them as returning NULL on error, but
> they return an ERR_PTR on error; update the documentation to match.
> 
> The documentation comment for ext4_wait_block_bitmap describes it as
> returning 1 on error, but it returns -errno on error; update the
> documentation to match.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Applied, thanks.

					- Ted
