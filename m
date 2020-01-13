Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28651139C94
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 23:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAMWcn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 17:32:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59177 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728800AbgAMWcm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 17:32:42 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DMWcK5002794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 17:32:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D44E84207DF; Mon, 13 Jan 2020 17:32:37 -0500 (EST)
Date:   Mon, 13 Jan 2020 17:32:37 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ext4: Rename ext4_kvmalloc() to
 ext4_kvmalloc_nofs() and drop its flags argument
Message-ID: <20200113223237.GL76141@mit.edu>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
 <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 05:05:22PM +0900, Naoto Kobayashi wrote:
> Rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and drop
> its flags argument, because ext4_kvmalloc() callers must be
> under GFP_NOFS (otherwise, they should use generic kvmalloc()
> helper function).
> 
> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>

Thanks, applied.

					- Ted
