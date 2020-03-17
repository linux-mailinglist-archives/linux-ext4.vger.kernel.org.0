Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD691882F9
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Mar 2020 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCQMHz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Mar 2020 08:07:55 -0400
Received: from sonic316-53.consmr.mail.ne1.yahoo.com ([66.163.187.179]:37910
        "EHLO sonic316-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgCQMHw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Mar 2020 08:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446871; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=T6Z0FPCnZgKKpK9b8FfgHNiU2BtOean/TzGlAyV3IG2QIKWt/MdISKOTLWerRcST68UycKkhmaz7MDDuArwlXk5zGtob8TiVFkWsqSziphO/Agfewqm4N9u51hZuJ2syVTb667uznRtVFuwa4tY094GxRTFhVroLnWuH6j1RCUD6U67QDEKb6mKg18eL/D/xEezJlrUAjV3/R1PEFjQarmRMqLiOIEUNfOjXLM7kJnF4szNNkr+5Glc+5wz5Bd/UcwK41ekSjSVkMm9Xn6GIrsNFCwx6Fqw5nblKMcHdLgk1uQCMeZOJiIKNDKNiIH9M3WyiiLCXOM3HQ98MFiR9Pg==
X-YMail-OSG: w.YKPVQVM1k7is_QUUK5S4RW.TsaT9i.xF7hLE3A1PEApG62VJUpck22P4pV0As
 5O84f4sof_i0VXCXTRR_Q2_mb9bhTB.eRc4d57pQryozIcx_SP8el.q7sLZh_e.L49yjdkIh8iIG
 JGuveHSDwk_cScO82WyY7vrKbzgm3GsPyuaQ5WyCJPBW4O._Wp2PRhYbmL63jDSn0lEINVK_0BE9
 A_LhKjtGThcZEvmIfrn3b9Lrzva_zep5TP2kRlrifaJY5V_LuzOj0TSQaToi35Vh1y4Wxjwx.yHi
 FaLjZQFZbJDueS0uDggKppprSyOXIMBWypnRaDVEU8pBjv_dBJyCpeQ6GLSdFrX0avy0b_b7j9T9
 rIctSiWyTlhnAEEGdaOX_rxrx09YIIdMI2iRqhr2F35J7bIoPbczL9w7gfwusShtcbZn0tXc.mtB
 MiO4EIAetlu_MnLbyEekwbH_Ni_YCEzTh5j3Tl150VZVJVxq4Bdwd921lcI3x9JPTaeuWmg7eDgP
 7vZ43WsawrnjkzIQa1vI70pMaZmU4.EblbIWq_0_BJrbaEz3irUCwPBYd6DPso5AzSepx0gBDt.i
 OD1Xsx3ZO_Lc9DBBHCdvlGq2ATV6h1nVWEJCjG73HAD1s3mO32G0TZmgCOZKNlt688w9YEmZUgKp
 nEhj0xKaWimxSHHA7peYl4zMHEgT.3o3xPdNNpGJdApmypTtSjg30YBXFUnt6E9uwVM5fP88lBW4
 b1ABlCW7NXbovO2fKbsQ5WaT8V37dU6rEhjAZIQTBdgDe0Q.EEusBbmLHyLv_53dUabcWDMX5bH3
 CR.Ei_s.QF2o1zqKQyRRf.t5K1IGQNFW8soHRtJnEgl_zsjmTLUOAZsH51QqswTNb.Zd5vzDsO7q
 I0ryknTbBIe1rhE7jFPtJum0V8YJDpea3HONAIAtoDX72PIuJOLiLVpUJqRmRpo09DIDgvEBMs4f
 P2_.LNBubthhj4HDy4LaN2pX_2mrZO0HYJ.uB09gwsCCg1pFeRVEylm0TmPu1DBHht.TG80wy7t_
 kkjR_lSnhlLy_tlkABYefKfEm0vMN4Qn.90oWiQKaA6rJy8jr9D.ukOsQVXpiLUyoXlAOO568Q36
 RWvMYh1wNrFhWNIKlAPlTxk141qffkQ4MN9.t0trMUP4.4y4v5xqgwcxs14q_dY9.vshomO8v5A9
 nehWEOP13qLHoQgt2Xgu0.4Eg7.KNTU2pU30PxPxWkJFIj6TJvtz6zPXZSj1WWEa4g15zHELNIyw
 i5kGWXvTjtU0thp0n.Ls2aFbIK1d2sYi.m5ewz9uPiAab.Jd18XqTI5W2Cyt0jL2uc7dOtyKua.n
 qSiXzZWX3cA2JXJfIHgaW3xD82fA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:07:51 +0000
Date:   Tue, 17 Mar 2020 12:05:51 +0000 (UTC)
From:   Stephen Li <stenn8@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <401256497.1842591.1584446751182@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <401256497.1842591.1584446751182.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
