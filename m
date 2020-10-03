Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AD28217B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJCE71 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:59:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53543 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCE71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:59:27 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934xGtI017783
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:59:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DA11542003C; Sat,  3 Oct 2020 00:59:15 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:59:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Hui Su <sh_def@163.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FIX the comment of struct jbd2_journal_handle
Message-ID: <20201003045915.GI23474@mit.edu>
References: <20200922171231.GA53120@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922171231.GA53120@rlk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 23, 2020 at 01:12:31AM +0800, Hui Su wrote:
> the struct name was modified long ago, but the comment still
> use struct handle_s.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Tnanks, applied.  I updated the commit summary to be:

    jbd2: fix the comment of struct jbd2_journal_handle

					- Ted
