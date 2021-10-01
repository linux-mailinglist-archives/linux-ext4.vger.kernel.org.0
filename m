Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0741E629
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJADNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 23:13:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38659 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbhJADNH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 23:13:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1913BER3009042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 23:11:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5AB1015C34A8; Thu, 30 Sep 2021 23:11:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix loff_t overflow in ext4_max_bitmap_size()
Date:   Thu, 30 Sep 2021 23:11:13 -0400
Message-Id: <163305786450.211691.6215423597966857187.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
References: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 5 Jun 2021 10:39:32 +0530, Ritesh Harjani wrote:
> We should use unsigned long long rather than loff_t to avoid
> overflow in ext4_max_bitmap_size() for comparison before returning.
> w/o this patch sbi->s_bitmap_maxbytes was becoming a negative
> value due to overflow of upper_limit (with has_huge_files as true)
> 
> Below is a quick test to trigger it on a 64KB pagesize system.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix loff_t overflow in ext4_max_bitmap_size()
      commit: f9b9e1afe996e8b4a0a2ea8481c41756fff53d08

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
