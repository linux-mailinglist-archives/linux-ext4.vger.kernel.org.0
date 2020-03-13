Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7112D1847DB
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Mar 2020 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMNS1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Mar 2020 09:18:27 -0400
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:40859 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgCMNS1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Mar 2020 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584105505; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PqCDxQfCg2iXWFLWyS87kbDWdRmdqGkDSruSiWOQI7UIgax5bNYx4A4Rey1bWvcKF3XT6QKl959Fyud83drnyJfQF9gF7M+xsQzdI66VmQx9+vrMVpT2M0O+c/9+2DRo4olDl6OYwMHHSbmX1xabrZYoJuzyzJz+ZTDtVArXCIwdDNF3/Bc5sMtfk9oIzYOvNSK2Xc4AzoGRKBtEcd9sLg4BAaRbsa2m8DOYP/fASJiPJl93zGEaKBAC22TXCDbl4c/d9l1+hbZXOGE51lSq3V1uGL37/y0HegMIbH5w4ZR/u6kSubQqIDFR88ALtoHxgrSixfC06ijz4sgJVcGUVg==
X-YMail-OSG: g5b6MSoVM1nIpydy3ar1d40LJMOsN.vrglqUHYmrnIcNS0DTTmB_WxDeK1Z6usW
 GTX7_CDWVEZEi1KDWSN6EXe.9ob_HOEa9piI77_pDJa6Qpifys3LOXVXtQxLjesjyeKdy_339TD2
 BSn8gOlZ.wSKq2hkGtCQXzj0M.MpKoK0rr3AyeZFnyqtTXSBg3sq_9UQXuo_xkYTHi_Yv8aPuxlm
 Zi4__ILOzo8EiPBg7UGUrlzyXAbkRXjFb6C_sfFegse6fZ.2QK4ZnZhIQ307phWrEuDAzCXJQHyH
 OLQfnSdKPajlXZ.ve_Dxz5PEIZtHSfh5o4pYsl8IqE0y0lJjnbk3DopSP27CO91Emv9ylXccoSvw
 0dnsNPCbg4BnxS_bRjmxEzoTlxIJxET3YTp4j4YuzrbrGoKzP9n2GKR9biI7kmFXEc.ZqQJCVYNc
 fdJx.7TK0WU0dj4tpmCYeChxPRdPjn_gR4.p7qTE7eAGqFpdT7cSkrCfclJBTyyi3vBoZrpFsbdE
 2pG2ePoFRZjruSI_RSQVsaP5aV59vJqwtxj54tVOCf4RsFAVD5Z1ME23IzcIjMgMyhS1CY6KpuGo
 i4bcA2xgeH3UHIo2JGxdLzcOxd9Zh_W_jv7LwY60JZDxqexklSjUOaAvGDLkSYkOS6JIpvmIkv_d
 I3BWxV52GTnZklyag7l_YJ9ZnqwhrDj6zV6MfRZ9onmUTF2_XBqxO2nvthBCT5pasgi.xsQ1NkYF
 hL_CqA4xGJZXlIG1q5UnVIlF0uvCvE9iT1SigjW_MihX47ek_683fcgb4qih9O46UFis35NYkV_5
 IBuQBVzNvRi4mQXxBRKutxITGMnFnt3jIoPBQSk.LzwnioYqWvZHOsBss9BMpIa4ehDeT0p3WL3M
 Z1ySFZFx4fdpzmP5SItduyqtoEGvP1Vnl.4r6KIEppi_bpIb3d.s2KqXgRtXgkRpSD7Dy_kQKveV
 92AElRrGc_zVxgYcFyIIaK.Phqxfw7zFLfrE8ZWKbAFck2ER3RbJ3LKViS0Fawvid6APAzJDwPT4
 su5roG6IHHggwMaVt0L5Z8IES_7pulVW9W0pbV4aCvsZS_I.Md1neknoNtyMen0Xw_wYlUrc4tTx
 9LKC8HiguGsB0CQpO_ocyUeRgz7R1q8Rjnx1qmfD0WMM81XX2i6ENSBtt6pgDhr40oGn6S_kEs4i
 KyYX_SaQAiYBJA1IvYiXw9dBmzWXyhqQTrOvIHk2740yWN6v2Hzr5sfa4e1s0rIzEO0T1x8lukZX
 XdtNvaimLnYloDjWv0eWCTxppqqFiflfnNDfmg.isEXGgOPsS_f95rHVnpOsRjY9UUH.EfkpMGkH
 vwo5eeVbsHbS5IbhynSTc81dvFWzGffVm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 13 Mar 2020 13:18:25 +0000
Date:   Fri, 13 Mar 2020 13:18:21 +0000 (UTC)
From:   Mr Moussa Dauda <officefilelee@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <785613278.2842327.1584105501153@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <785613278.2842327.1584105501153.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
