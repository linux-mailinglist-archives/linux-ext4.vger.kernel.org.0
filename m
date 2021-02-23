Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366EA32303F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhBWSHa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 13:07:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55039 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233790AbhBWSH1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 13:07:27 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11NI6Zkd019098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 13:06:35 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0793A15C342C; Tue, 23 Feb 2021 13:06:35 -0500 (EST)
Date:   Tue, 23 Feb 2021 13:06:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/4] e2fsck: don't ignore return values in
 e2fsck_rewrite_extent_tree
Message-ID: <YDVEKuuiVEJER5/N@mit.edu>
References: <20210223174156.308507-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223174156.308507-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 23, 2021 at 09:41:53AM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Don't ignore return values of library function calls in
> e2fsck_rewrite_extent_tree.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, I've applied this patch series.

						- Ted
