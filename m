Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6E28BD2C
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390270AbgJLQDc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 12:03:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44633 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389555AbgJLQDc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 12:03:32 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09CG3R7X001430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 12:03:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 25875420107; Mon, 12 Oct 2020 12:03:27 -0400 (EDT)
Date:   Mon, 12 Oct 2020 12:03:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] config: upgrade xfsprogs to v5.8.0
Message-ID: <20201012160327.GS235506@mit.edu>
References: <20201009041143.244304-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009041143.244304-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 09:11:43PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This is needed to run some of the newer encryption tests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
