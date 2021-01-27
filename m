Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD6306167
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 17:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhA0Q6M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 11:58:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41706 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234624AbhA0Q4w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 11:56:52 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10RGu3T9018685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 11:56:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 033CF15C3709; Wed, 27 Jan 2021 11:56:02 -0500 (EST)
Date:   Wed, 27 Jan 2021 11:56:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 0/8] e2fsck: add fast commit replay path
Message-ID: <YBGbIjLz0iWBIom8@mit.edu>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:56PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch series consists of modified e2fsck fast commit replay
> patches from the patch series "[PATCH v3 00/15] Fast commit changes
> for e2fsprogs" sent on Jan 20, 2021
> (https://patchwork.ozlabs.org/project/linux-ext4/list/?series=225577&state=*). All
> the patches except fast commit recovery path were merged upstream. So,
> this series contains only the fast commit replay patch changes.
> 
> Verified that all the regression tests pass:
> 367 tests succeeded     0 tests failed
> 
> New fast commit recovery test:
> j_recover_fast_commit: ok

I've applied this patch series, thanks!

						- Ted
