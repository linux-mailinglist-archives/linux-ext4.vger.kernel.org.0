Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328E3DA3A
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 02:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfD2Ag7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 20:36:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51909 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbfD2Ag7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 20:36:59 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T0aquZ022129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 20:36:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B56C9420023; Sun, 28 Apr 2019 20:36:51 -0400 (EDT)
Date:   Sun, 28 Apr 2019 20:36:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: Re: [PATCH] libext2fs: remove unused variable 'buff'
Message-ID: <20190429003651.GF3789@mit.edu>
References: <20190422210843.185382-1-ebiggers@kernel.org>
 <85sgu9s6us.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85sgu9s6us.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 23, 2019 at 12:06:35AM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > From: Eric Biggers <ebiggers@google.com>
> >
> > In ext2fs_dirhash2(), the outer 'buff' variable is never used.
> >
> > Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks, applied.

					- Ted
