Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D4139A34
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAMTbP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 14:31:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55978 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgAMTbP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 14:31:15 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DJV9WT003088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:31:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4BB614207DF; Mon, 13 Jan 2020 14:31:09 -0500 (EST)
Date:   Mon, 13 Jan 2020 14:31:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fscrypt: optimize fscrypt_zeroout_range()
Message-ID: <20200113193109.GB76141@mit.edu>
References: <20191226160813.53182-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226160813.53182-1-ebiggers@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 10:08:13AM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently fscrypt_zeroout_range() issues and waits on a bio for each
> block it writes, which makes it very slow.
> 
> Optimize it to write up to 16 pages at a time instead.
> 
> Also add a function comment, and improve reliability by allowing the
> allocations of the bio and the first ciphertext page to wait on the
> corresponding mempools.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

