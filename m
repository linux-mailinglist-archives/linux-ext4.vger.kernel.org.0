Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7812D5EB
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaDL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 22:11:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33642 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfLaDL6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 22:11:58 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV3Bn2A032750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:11:50 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ABA22420485; Mon, 30 Dec 2019 22:11:48 -0500 (EST)
Date:   Mon, 30 Dec 2019 22:11:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca, lixi@ddn.com,
        wshilong@ddn.com
Subject: Re: [PATCH 1/2] e2fsck: fix to return ENOMEM in alloc_size_dir()
Message-ID: <20191231031148.GD3669@mit.edu>
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 26, 2019 at 06:03:58PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Two memory allocation return check is missed.
>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Thanks, applied.

					- Ted
