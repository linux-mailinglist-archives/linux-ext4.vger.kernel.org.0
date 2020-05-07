Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E71C92CA
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgEGO7E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 May 2020 10:59:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43821 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725985AbgEGO7E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 May 2020 10:59:04 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 047EwwVn021912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 May 2020 10:59:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C66F7421C7D; Thu,  7 May 2020 10:58:58 -0400 (EDT)
Date:   Thu, 7 May 2020 10:58:58 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] EXT4: acl: Fix a style issue
Message-ID: <20200507145858.GK404484@mit.edu>
References: <20200416141456.1089-1-carlosteniswarrior@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416141456.1089-1-carlosteniswarrior@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 16, 2020 at 04:14:56PM +0200, Carlos Guerrero Alvarez wrote:
> From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
> 
> Fixed an if statement where braces were not needed.
> 
> Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

Applied, thanks.

					- Ted
