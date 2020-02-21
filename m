Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E678A168712
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUS43 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 13:56:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54400 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729397AbgBUS42 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 13:56:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01LIuM29015170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 13:56:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7C90C4211EF; Fri, 21 Feb 2020 13:56:22 -0500 (EST)
Date:   Fri, 21 Feb 2020 13:56:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix mount failure with quota configured as module
Message-ID: <20200221185622.GA873427@mit.edu>
References: <20200221100835.9332-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221100835.9332-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 11:08:35AM +0100, Jan Kara wrote:
> When CONFIG_QFMT_V2 is configured as a module, the test in
> ext4_feature_set_ok() fails and so mount of filesystems with quota or
> project features fails. Fix the test to use IS_ENABLED macro which works
> properly even for modules.
> 
> Fixes: d65d87a07476 ("ext4: improve explanation of a mount failure caused by a misconfigured kernel")
> Signed-off-by: Jan Kara <jack@suse.cz>

Whoops, good catch.  Thanks, applied.

					- Ted
