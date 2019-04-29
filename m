Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605ACDA3B
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfD2Ahq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 20:37:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52084 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbfD2Ahq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 20:37:46 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T0beWQ022366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 20:37:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4CDEA420023; Sun, 28 Apr 2019 20:37:40 -0400 (EDT)
Date:   Sun, 28 Apr 2019 20:37:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: remove unused variable 'tmp_inode'
Message-ID: <20190429003740.GG3789@mit.edu>
References: <20190422211950.196986-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422211950.196986-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 22, 2019 at 02:19:50PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In parse_inode_csum(), the outer 'tmp_inode' variable is never used.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
