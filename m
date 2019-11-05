Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5FF07A3
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 22:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfKEVE1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 16:04:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60095 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbfKEVE0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 16:04:26 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA5L4Itb008600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 16:04:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BB496420311; Tue,  5 Nov 2019 16:04:16 -0500 (EST)
Date:   Tue, 5 Nov 2019 16:04:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/25 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191105210416.GC26959@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 05, 2019 at 05:44:06PM +0100, Jan Kara wrote:
> Hello,
> 
> Here is v3 of this series with couple more bugs fixed. Now all failed tests Ted
> higlighted pass for me.

Thanks, I've applied this to the ext4 git tree.  Thanks for your work
on this patch series!

				- Ted
