Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99836139955
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 19:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMSwz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 13:52:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48289 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727726AbgAMSwz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 13:52:55 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DIqd4b019539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 13:52:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6D15D4207DF; Mon, 13 Jan 2020 13:52:39 -0500 (EST)
Date:   Mon, 13 Jan 2020 13:52:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary assignment in
 ext4_htree_store_dirent()
Message-ID: <20200113185239.GB30418@mit.edu>
References: <20191206054317.3107-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206054317.3107-1-cgxu519@mykernel.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 06, 2019 at 01:43:17PM +0800, Chengguang Xu wrote:
> We have allocated memory using kzalloc() so don't have
> to set 0 again in last byte.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks, applied.

					- Ted
