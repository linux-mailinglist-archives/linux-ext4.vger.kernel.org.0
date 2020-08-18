Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB6248DDE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRSWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:22:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46489 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgHRSWV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:22:21 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IIMBso015201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:22:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EC616420DC0; Tue, 18 Aug 2020 14:22:10 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:22:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mballoc: Replace seq_printf with seq_puts
Message-ID: <20200818182210.GE34125@mit.edu>
References: <20200810022158.9167-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810022158.9167-1-vulab@iscas.ac.cn>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 10, 2020 at 02:21:58AM +0000, Xu Wang wrote:
> seq_puts is a lot cheaper than seq_printf, so use that to print
> literal strings.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Applied, thanks.

					- Ted
