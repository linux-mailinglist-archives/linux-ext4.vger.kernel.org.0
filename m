Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EC52512D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiELPWI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245501AbiELPWH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 11:22:07 -0400
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0995F26D
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 08:22:04 -0700 (PDT)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 225D72DA;
        Thu, 12 May 2022 17:22:03 +0200 (CEST)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id DD21B2800285; Thu, 12 May 2022 17:22:02 +0200 (CEST)
Date:   Thu, 12 May 2022 17:22:02 +0200
From:   Vincent Lefevre <vincent@vinc17.net>
To:     linux-ext4@vger.kernel.org
Subject: Re: ext4: unexpected delayed file creation with a 5.17 kernel
Message-ID: <20220512152202.GE3360150@zira.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.net>,
        linux-ext4@vger.kernel.org
References: <20220511135917.GA3381602@zira.vinc17.org>
 <Yn0fMj0jXPrMIZd9@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yn0fMj0jXPrMIZd9@mit.edu>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.4+14 (d448c911) vl-138565 (2022-05-08)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022-05-12 10:52:34 -0400, Theodore Ts'o wrote:
> On Wed, May 11, 2022 at 03:59:17PM +0200, Vincent Lefevre wrote:
> > Hi,
> > 
> > On a Linux machine (12-core x86_64 Debian/unstable, 5.17 kernel)
> > with an ext4 filesystem, I got a file born 30 seconds after its
> > actual creation by a script. This is completely unreproducible.
> 
> completely *reproducible* or *unreproducible*?

Completely unreproducible. This was the only time I noticed such an
issue with ext4.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
