Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EEF3AB6B8
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhFQPDb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 11:03:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50125 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230507AbhFQPDa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 11:03:30 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HF1AHH010114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 11:01:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C5AD15C3CBA; Thu, 17 Jun 2021 11:01:10 -0400 (EDT)
Date:   Thu, 17 Jun 2021 11:01:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: remove set but rewrite variables
Message-ID: <YMtjttGok4hZq821@mit.edu>
References: <1621493752-36890-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621493752-36890-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 20, 2021 at 02:55:52PM +0800, Tian Tao wrote:
> In the ext4_dx_add_entry function, the at variable is assigned but will
> reset just after “again:” label. So delete the unnecessary assignment.
> this will not chang the logic.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Applied, thanks.

					- Ted
