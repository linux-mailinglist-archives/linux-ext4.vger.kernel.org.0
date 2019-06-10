Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF83ADD2
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 06:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfFJEPh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jun 2019 00:15:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39450 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728037AbfFJEPh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jun 2019 00:15:37 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A4FMNQ008935
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jun 2019 00:15:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 34E40420481; Mon, 10 Jun 2019 00:15:22 -0400 (EDT)
Date:   Mon, 10 Jun 2019 00:15:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 1/2] ext4: only set project inherit bit for directory
Message-ID: <20190610041522.GB15963@mit.edu>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 06, 2019 at 01:32:24PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Thanks, applied to the ext4 tree.

				- Ted
