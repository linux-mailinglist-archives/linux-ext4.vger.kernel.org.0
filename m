Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB42B78054E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357954AbjHRFFr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357978AbjHRFFU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C693AAC
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55DHD026898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335115; bh=S+PPp3owwI0LnFl53yptF4hV5L/pAn9/cQFUOhH6JOw=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=YZVmpAzQ7C5nuhKJPh2zcFy0cL7ewnb09K5ryNrPqaoEZXsdHu8uwgkfPLheeDatW
         KHYHjjVzLJE6+pb34W23ObLuS2YeUeazg0AcdSKoHWOtByFxWMMpsDHUwtzQP9P07Z
         AlMTr0dzhGVMCamcQ5I85UxjO4khfKJRvTQRloqL4iwl+rcmId0hryYBRS3elgq2fn
         Vfvqo2eEMU5UvZ2sGfRc99eAMObFJzXt1bJU8RbIBmVy+GZOX87yU0hU6XuUPMdb/P
         1YXbHPJR9RPwJgKQ9+KY8jDseHzuaf75V2hgYltUXZ56wwfqir5IXNPZeu9I06koHl
         VKTf7ULHRS4xw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3406515C0504; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Hongfei <luhongfei@vivo.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, opensource.kernel@vivo.com
Subject: Re: [PATCH] fs/ext4: Change the type of blocksize from 'int' to 'unsigned int' in ext4_mb_init_cache
Date:   Fri, 18 Aug 2023 01:05:09 -0400
Message-Id: <169233503393.3504102.17016551179934361361.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230707105516.9156-1-luhongfei@vivo.com>
References: <20230707105516.9156-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 07 Jul 2023 18:55:16 +0800, Lu Hongfei wrote:
> The return value type of i_blocksize() is 'unsigned int', so the
> type of blocksize has been modified from 'int' to 'unsigned int'
> to ensure data type consistency.
> 
> 

Applied, thanks!

[1/1] fs/ext4: Change the type of blocksize from 'int' to 'unsigned int' in ext4_mb_init_cache
      commit: 7431b253dfc2240241e2c1fb8abf7bfeb3c105a6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
