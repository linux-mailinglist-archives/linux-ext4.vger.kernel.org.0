Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17693591812
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHMBNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHMBNJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 21:13:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74117AA3E2
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 18:13:08 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27D1D1YT017557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 21:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660353183; bh=+TJ/UfbovO1ClAGo+NMqXXBx43yB4AXsfGbxhBIwf7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bKLAUMNLuzuInLbomvNl2TqyVyA6UcgbWd6u0nYv570PZASNJFcCyOs/R3nH1kfJJ
         6ZxI8IiUjlizv6NTzqHZ69U6djh/ZOnTDozII7oQeY70tDv9MeVV4u/Wa7yclWEec7
         uq//tHNDSzR9/ss8qa0bEDDxpVw/AwU0fDrvz6IaJKN15E8H8xLCqHQ5SXaojgP+fU
         cVuapQ/97bX4V48g/KqvRsgMsgmaTE2r28VXjTWfDPLl/OzfjXhmw1xXQ7GQ3rWtn+
         vrl7Z8DfCD/uigCpnshm82WGqca8pmUlL+gt/xeqZrkC3LcNg/5ZNzv5EhPrCyHIDo
         fglQtfp0+lFXg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 395538C2DE9; Fri, 12 Aug 2022 21:13:01 -0400 (EDT)
Date:   Fri, 12 Aug 2022 21:13:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH, resend] misc: use ext2_ino_t instead of ino_t
Message-ID: <Yvb6nZ0vDaNagcIU@mit.edu>
References: <20220805212854.74082-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805212854.74082-1-adilger@dilger.ca>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 05, 2022 at 03:28:54PM -0600, Andreas Dilger wrote:
> From: Andreas Dilger <adilger@whamcloud.com>
> 
> Some of the new fastcommit and casefold changes used the system
> "ino_t" instead of "ext2_ino_t" for handling filesystem inodes.
> This causes printf warnings if the system "ino_t" is of a different
> size.  Use the library "ext2_ino_t" for consistency.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Applied, thanks!

					- Ted
