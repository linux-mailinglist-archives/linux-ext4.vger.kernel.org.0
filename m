Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42417DA48
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfD2BAM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 21:00:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56090 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbfD2BAM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 21:00:12 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T106rL027920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 21:00:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17B2B420023; Sun, 28 Apr 2019 21:00:06 -0400 (EDT)
Date:   Sun, 28 Apr 2019 21:00:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs 10/10] ext4.5.in: Document design changes on
 the casefold attribute
Message-ID: <20190429010005.GI3789@mit.edu>
References: <20190413054317.7388-1-krisman@collabora.com>
 <20190413054317.7388-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413054317.7388-11-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 13, 2019 at 01:43:17AM -0400, Gabriel Krisman Bertazi wrote:
> Document the fact that the encoding support is only used by directories
> with the +F attribute.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks, applied.

						- Ted
