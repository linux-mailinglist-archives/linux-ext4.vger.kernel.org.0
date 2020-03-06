Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9317B3C0
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 02:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCFB3F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 20:29:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41217 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbgCFB3F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 20:29:05 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0261T01U005509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 20:29:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E08D742045B; Thu,  5 Mar 2020 20:28:59 -0500 (EST)
Date:   Thu, 5 Mar 2020 20:28:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: clean up error return for
 convert_initialized_extent()
Message-ID: <20200306012859.GK20967@mit.edu>
References: <20200218202656.21561-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218202656.21561-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 03:26:56PM -0500, Eric Whitney wrote:
> Although convert_initialized_extent() can potentially return an error
> code with a negative value, its returned value is assigned to an
> unsigned variable containing a block count in ext4_ext_map_blocks() and
> then returned to that function's caller. The code currently works,
> though the way this happens is obscure.  The code would be more
> readable if it followed the error handling convention used elsewhere
> in ext4_ext_map_blocks().
> 
> This patch does not address any known test failure or bug report - it's
> simply a cleanup.  It also addresses a nearby coding standard issue.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Thanks, applied.

					- Ted
