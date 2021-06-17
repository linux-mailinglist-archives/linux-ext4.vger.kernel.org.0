Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4523F3ABD5D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhFQUZh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 16:25:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45622 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230137AbhFQUZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 16:25:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HKNHjn012476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 16:23:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6AEDF15C3CBA; Thu, 17 Jun 2021 16:23:17 -0400 (EDT)
Date:   Thu, 17 Jun 2021 16:23:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     chenyichong <chenyichong@uniontech.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use local variables ei instead of invoking function
 EXT4_I
Message-ID: <YMuvNfv7CWVLvuie@mit.edu>
References: <20210526052930.11278-1-chenyichong@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526052930.11278-1-chenyichong@uniontech.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 26, 2021 at 01:29:30PM +0800, chenyichong wrote:
> Signed-off-by: chenyichong <chenyichong@uniontech.com>

Applied, thanks.

					- Ted
